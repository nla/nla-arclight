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
        expect(collection_identifier_value).to eq "level1 level2, unit1 unit2"
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
end
