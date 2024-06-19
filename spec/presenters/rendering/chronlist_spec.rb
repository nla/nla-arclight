# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rendering::Chronlist do
  include Capybara::RSpecMatchers
  let(:document) { instance_double(SolrDocument) }
  let(:context) { double }
  let(:options) { {} }

  describe "#render" do
    subject(:rendered) { Blacklight::Rendering::Pipeline.new(values, field_config, document, context, [described_class], options).render }

    let(:note) { JSON.parse(IO.read("spec/files/notes/chronlist.json")) }
    let(:values) { note["chronlist"] }
    let(:field_config) { Blacklight::Configuration::NullField.new }

    it "renders a chronlist" do
      expect(rendered).to have_table(class: %w[table-light table-responsive table-striped table-hover])
      expect(rendered).to have_css("thead.table-purple")
      expect(rendered).to have_css("tbody.table-group-divider")
      expect(rendered).to have_css("td.text-nowrap")

      expect(rendered).to have_css("th", text: "Date")
      expect(rendered).to have_css("th", text: "Event")

      expect(rendered).to have_css("td", text: "1925")
      expect(rendered).to have_css("td", text: "Born in Yarram, Victoria, on 26 October")

      expect(rendered).to have_css("td", text: "1942-1943")
      expect(rendered).to have_css("td", text: "Rhys Jones Medal, Australian Archaeological Association")
    end

    context "when the date has a calendar structure" do
      let(:note) { JSON.parse(IO.read("spec/files/notes/chronlist_calendar.json")) }

      it "renders the chronlist with just the date" do
        expect(rendered).to have_table(class: %w[table-light table-responsive table-striped table-hover])
        expect(rendered).to have_css("thead.table-purple")
        expect(rendered).to have_css("tbody.table-group-divider")
        expect(rendered).to have_css("td.text-nowrap")

        expect(rendered).to have_css("th", text: "Date")
        expect(rendered).to have_css("th", text: "Event")

        expect(rendered).to have_css("td", text: "1849")
        expect(rendered).to have_css("td", text: "Born in Glebe, Sydney, 18 January")

        expect(rendered).to have_css("td", text: "1891-92")
        expect(rendered).to have_css("td", text: "Attorney-General in the Dibbs Protectionist Ministry")
      end
    end
  end
end
