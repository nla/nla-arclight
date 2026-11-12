# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Bookmark button styling", driver: :selenium_chrome_headless, type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:states) { %w[normal hover focus open] }
  let(:button_labels) { ["Cite all", "Export all"] }

  before do
    user = create(:user)
    user.bookmarks.create!(document_id: "280011976", document_type: "SolrDocument")
    sign_in user
    fixture = File.read("spec/files/solr/280011976.json")
    [:get, :post].each do |method|
      stub_request(method, /solr:8983/).to_return(body: fixture, headers: {"Content-Type" => "application/json"})
    end
    stub_request(:get, %r{catservices.test/catalogue-services/patron/2fa/email/})
      .to_return(body: {status: false}.to_json, headers: {"Content-Type" => "application/json"})
  end

  after do
    page.driver.browser.execute_cdp("Emulation.setEmulatedMedia", features: [])
  end

  %w[light dark].each do |scheme|
    it "gives Cite all and Export all matching colours in #{scheme} mode" do
      page.driver.browser.execute_cdp("Emulation.setEmulatedMedia", features: [{name: "prefers-color-scheme", value: scheme}])
      visit bookmarks_path
      page.execute_script("document.head.insertAdjacentHTML('beforeend', '<style>* {transition: none !important}</style>')")
      expect(page).to have_button("Export all", class: "btn-primary")

      states.each do |state|
        colours = button_labels.map do |label|
          find("h1").hover
          page.execute_script("document.activeElement.blur()")
          button = find_button(label)
          button.hover if state == "hover"
          button.execute_script("this.focus()") if state == "focus"
          button.click if state == "open"
          result = button.evaluate_script("[getComputedStyle(this).color, getComputedStyle(this).backgroundColor, getComputedStyle(this).borderTopColor]")
          button.click if state == "open"
          result
        end
        expect(colours.first).to eq(colours.last), "Mismatched #{state} colours in #{scheme} mode: #{colours.inspect}"
      end
    end
  end
end
