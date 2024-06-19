# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rendering::Table do
  include Capybara::RSpecMatchers
  let(:document) { instance_double(SolrDocument) }
  let(:context) { double }
  let(:options) { {} }

  describe "#render" do
    subject(:rendered) { Blacklight::Rendering::Pipeline.new(values, field_config, document, context, [described_class], options).render }

    let(:note) { JSON.parse(IO.read("spec/files/notes/table.json")) }
    let(:values) { note["table"] }
    let(:field_config) { Blacklight::Configuration::NullField.new }

    it "renders a table" do
      expect(rendered).to have_table(class: %w[table-light table-responsive table-striped table-hover])
      expect(rendered).to have_css("thead.table-purple")
      expect(rendered).to have_css("tbody.table-group-divider")

      expect(rendered).to have_css("thead tr", count: 1)
      expect(rendered).to have_css("th", text: "Series")
      expect(rendered).to have_css("th", text: "File/Item")
      expect(rendered).to have_css("th", text: "Box")

      expect(rendered).to have_css("tbody tr", count: 34)
    end
  end
end
