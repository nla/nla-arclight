require "rails_helper"

RSpec.describe SolrDocument do
  describe "#collection_identifier" do
    context "when level_ssm and unitid_ssm are present" do
      subject(:collection_identifier_value) do
        document = described_class.new(
          level_ssm: ["level1", "level2"],
          unitid_ssm: ["unit1", "unit2"]
        )
        document.collection_identifier
      end

      it "joins them with a comma" do
        expect(collection_identifier_value).to eq "level1 level2 unit1 unit2"
      end
    end

    context "when level_ssm is nil" do
      subject(:collection_identifier_value) do
        document = described_class.new(
          unitid_ssm: ["unit1", "unit2"]
        )
        document.collection_identifier
      end

      it "returns only unitid_ssm" do
        expect(collection_identifier_value).to eq "unit1 unit2"
      end
    end

    context "when unitid_ssm is nil" do
      subject(:collection_identifier_value) do
        document = described_class.new(
          level_ssm: ["level1", "level2"]
        )
        document.collection_identifier
      end

      it "returns only level_ssm" do
        expect(collection_identifier_value).to eq "level1 level2"
      end
    end

    context "when both level_ssm and unitid_ssm are nil" do
      subject(:collection_identifier_value) do
        document = described_class.new

        document.collection_identifier
      end

      it "returns an empty string" do
        expect(collection_identifier_value).to eq ""
      end
    end
  end

  describe "#extents_information" do
    context "when quantity, unit type, dimensions, and facet are present" do
      subject(:extents_information_value) do
        document = described_class.new(
          physdesc_quantity_ssi: ["1"],
          physdesc_unittype_ssi: ["item"],
          physdesc_dimensions_ssi: ["Unbranded"],
          physdesc_facet_ssi: ["Data CD (any content on recordable CD-R)"]
        )
        document.extents_information
      end

      it "is formatted as: quantity + unittype, dimension, facet" do
        expect(extents_information_value).to eq "1 item, Unbranded, Data CD (any content on recordable CD-R)"
      end
    end

    context "when quantity is nil" do
      subject(:extents_information_value) do
        document = described_class.new(
          physdesc_unittype_ssi: ["item"],
          physdesc_dimensions_ssi: ["Unbranded"],
          physdesc_facet_ssi: ["Data CD (any content on recordable CD-R)"]
        )
        document.extents_information
      end

      it "returns unittype, dimension, facet" do
        expect(extents_information_value).to eq "item, Unbranded, Data CD (any content on recordable CD-R)"
      end
    end

    context "when quantity and unittype are nil" do
      subject(:extents_information_value) do
        document = described_class.new(
          physdesc_dimensions_ssi: ["Unbranded"],
          physdesc_facet_ssi: ["Data CD (any content on recordable CD-R)"]
        )
        document.extents_information
      end

      it "returns only dimensions and facet" do
        expect(extents_information_value).to eq "Unbranded, Data CD (any content on recordable CD-R)"
      end
    end

    context "when all fields are nil" do
      subject(:extents_information_value) do
        document = described_class.new

        document.extents_information
      end

      it "returns an empty string" do
        expect(extents_information_value).to eq ""
      end
    end
  end
end
