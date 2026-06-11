# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlacklightRangeLimit::RangeFacetComponent, type: :component do
  let(:search_state) { double(to_h: {}) }

  let(:facet_field) do
    double(key: "date_range",
      label: "Date",
      selected_range_facet_item: nil,
      missing_selected?: false,
      min: "1900",
      max: "2024",
      range_queries: [],
      missing_facet_item: nil,
      search_state: search_state,
      range_config: {segments: true, maxlength: 4, textual_facets: false, chart_js: false})
  end

  describe "#render?" do
    it "returns true when min and max are present" do
      component = described_class.new(facet_field: facet_field)
      expect(component.render?).to be true
    end

    it "returns true when missing_facet_item is present even without min/max" do
      allow(facet_field).to receive_messages(min: nil, max: nil, missing_facet_item: double(value: "missing"))

      component = described_class.new(facet_field: facet_field)
      expect(component.render?).to be true
    end

    it "returns false when neither min/max nor missing_facet_item are present" do
      allow(facet_field).to receive_messages(min: nil, max: nil, missing_facet_item: nil)

      component = described_class.new(facet_field: facet_field)
      expect(component.render?).to be false
    end
  end
end
