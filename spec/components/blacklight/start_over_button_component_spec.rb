# frozen_string_literal: true

require "rails_helper"

RSpec.describe Blacklight::StartOverButtonComponent, type: :component do
  it "renders the start over button" do
    render_inline(described_class.new)

    expect(page).to have_css(".catalog_startOverLink.btn.btn-outline-secondary.btn-sm.arrow-before", text: I18n.t("blacklight.search.start_over"))
  end
end
