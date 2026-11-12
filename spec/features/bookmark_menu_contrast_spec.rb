# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Bookmark menu contrast", driver: :selenium_chrome_headless, type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:menu_labels) { ["Cite all", "Export all"] }
  let(:states) { %w[normal hover focus active] }

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

  %w[light dark].product([1200, 375]).each do |scheme, width|
    it "keeps both menus readable in #{scheme} mode at #{width}px" do
      page.driver.browser.execute_cdp("Emulation.setEmulatedMedia", features: [{name: "prefers-color-scheme", value: scheme}])
      page.current_window.resize_to(width, 800)
      visit bookmarks_path
      page.execute_script("document.head.insertAdjacentHTML('beforeend', '<style>* {transition: none !important}</style>')")

      menu_labels.each do |label|
        click_button label
        menu = find(".bookmarksTools .dropdown-menu.show")
        menu.all(".dropdown-item").to_a.each do |item|
          states.each do |state|
            find("h1").hover
            page.execute_script("document.activeElement.blur()")
            item.hover if state == "hover"
            item.execute_script("this.focus()") if state == "focus"
            item.execute_script("this.classList.add('active')") if state == "active"
            ratio = item.evaluate_script(<<~JS)
              (() => {
                const luminance = colour => {
                  const rgb = colour.match(/[0-9.]+/g).slice(0, 3).map(Number).map(value => {
                    value /= 255;
                    return value <= 0.04045 ? value / 12.92 : ((value + 0.055) / 1.055) ** 2.4;
                  });
                  return rgb[0] * 0.2126 + rgb[1] * 0.7152 + rgb[2] * 0.0722;
                };
                const style = getComputedStyle(this);
                const background = style.backgroundColor === 'rgba(0, 0, 0, 0)'
                  ? getComputedStyle(this.closest('.dropdown-menu')).backgroundColor : style.backgroundColor;
                const values = [luminance(style.color), luminance(background)];
                return (Math.max(...values) + 0.05) / (Math.min(...values) + 0.05);
              })()
            JS
            expect(ratio).to be >= 4.5
            item.execute_script("this.classList.remove('active')")
          end
        end
        click_button label
      end
    end
  end
end
