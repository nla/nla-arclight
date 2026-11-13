# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Finding-aid bookmark tools", driver: :selenium_chrome_headless, type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before do
    stub_request(:get, %r{catservices.test/catalogue-services/patron/2fa/email/})
      .to_return(body: {status: false}.to_json, headers: {"Content-Type" => "application/json"})
    fixture = JSON.parse(File.read("spec/files/solr/280011976.json"))
    [:get, :post].each do |method|
      stub_request(method, /solr:8983/).to_return(body: fixture.to_json, headers: {"Content-Type" => "application/json"})
    end
    user.bookmarks.create!(document_id: "280011976", document_type: "SolrDocument")
    sign_in user
  end

  [1200, 375].each do |width|
    it "opens citation and export menus without overlap at #{width}px" do
      page.current_window.resize_to(width, 800)
      visit bookmarks_path

      expect(page).to have_button("Cite all")
      expect(page).to have_button("Export all")
      rectangles = page.evaluate_script(<<~JS)
        Array.from(document.querySelectorAll('.bookmarksTools .dropdown-toggle')).map(button => {
          const rect = button.getBoundingClientRect();
          return {left: rect.left, right: rect.right, top: rect.top, bottom: rect.bottom};
        })
      JS
      cite, export = rectangles
      expect(cite["right"] + 8 <= export["left"] || cite["bottom"] + 8 <= export["top"]).to be(true)

      click_button "Export all"
      expect(page).to have_link("CSV (.csv)", visible: :visible)
      expect(page).to have_link("RIS (.ris)", visible: :visible)
      click_button "Cite all"
      expect(page).to have_link("MLA", visible: :visible)
      expect(page).to have_no_link("Preferred citation")
      expect(page).to have_no_link("Record metadata")
      expect(page).to have_link("Australian/Harvard", visible: :visible)
      click_link "APA"

      expect(page).to have_css(".citation-bibliography em", text: "19th century currency items")
      citation = find('[data-clipboard-target="source"]').text
      expect(citation).to include("19th century currency items", "MS 1139", "/finding-aids/catalog/280011976")
      page.execute_script(<<~JS)
        window.ClipboardItem = class { constructor(data) {this.data = data;} };
        Object.defineProperty(navigator, 'clipboard', {configurable: true, value: {
          write: async items => {
            window.copiedHTML = await items[0].data['text/html'].text();
            window.copiedCitation = await items[0].data['text/plain'].text();
          },
          writeText: text => {window.plainTextFallback = text; return Promise.resolve();}
        }});
      JS
      click_link "Copy all"
      expect(page).to have_link("Copied")
      expect(page.evaluate_script("window.copiedCitation")).to eq(citation)
      expect(page.evaluate_script("window.copiedHTML")).to include("<em>19th century currency items</em>")
      expect(page.evaluate_script("window.copiedCitation")).not_to include("<em>")

      page.execute_script("navigator.clipboard.write = () => Promise.reject(new Error('Not supported'))")
      click_link "Copied"
      expect(page.evaluate_script("window.plainTextFallback")).to eq(citation)

      page.execute_script("navigator.clipboard.write = undefined; window.plainTextFallback = null")
      click_link "Copied"
      expect(page.evaluate_script("window.plainTextFallback")).to eq(citation)
    end
  end
end
