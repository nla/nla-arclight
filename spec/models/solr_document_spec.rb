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

  describe "#extract_notes_by_header" do
    let(:document) do
      described_class.new(
        note_json_ssm: ["{\"head\":\"Conditions Governing Access\",\"p\":\"Please refer to the collection's catalogue record for the access conditions (<a href=\\\"http://nla.gov.au/nla.cat-vn1132324\\\">http://nla.gov.au/nla.cat-vn1132324</a>).\",\"audience\":\"internal\"}",
          "{\"head\":\"References\",\"p\":[\"References used in the creation of this finding aid include:\",\"<a href=\\\"http://nla.gov.au/nla.cat-vn5977580\\\">Australian colonial currency and promissory notes</a> by Michael P. Vort-Ronald, second edition, 2012 and <a href=\\\"http://nla.gov.au/nla.cat-vn2073970\\\">Standard catalogue of world paper money</a> by Albert Pick, vol 2, c1990.\"],\"audience\":\"internal\"}",
          "{\"head\":\"Scope and Contents\",\"p\":\"Includes merchants' promissory notes, Fijian treasury notes and money issued in \\\"New Australia\\\", Paraguay.\",\"audience\":\"internal\"}",
          "{\"head\":\"Conditions Governing Use\",\"p\":\"Copying and publishing of unpublished manuscript material is subject to copyright restrictions. For such material, written permission to publish must be obtained from the copyright holder(s). Copying of unpublished material for research purposes is permissible 50 years after the death of the creator of the material.\",\"audience\":\"internal\"}",
          "{\"head\":\"Immediate Source of Acquisition\",\"p\":\"Acquired from Tyrrell's Antiquarian Bookshop, Sydney, in 1953.\",\"audience\":\"internal\"}"]
      )
    end

    context "when notes contains a note with a header matching a localised string literal" do
      subject(:notes_value) do
        document.extract_notes_by_header("imm_source_acq")
      end

      it "returns the notes with the matching header" do
        expect(notes_value.join).to include "Acquired from Tyrrell's Antiquarian Bookshop, Sydney, in 1953."
      end
    end

    context "when notes does not contain a note with a header matching a localised string literal" do
      subject(:notes_value) do
        document.extract_notes_by_header("coll_retrieval_adv")
      end

      it "returns an empty array" do
        expect(notes_value).to eq []
      end
    end

    context "when header literal contains punctuation" do
      subject(:notes_value) do
        document = described_class.new(
          note_json_ssm: ["{\"head\":\"Biographical / Historical\",\"p\":\"Testing\",\"audience\":\"internal\"}"]
        )

        document.extract_notes_by_header("biog_hist")
      end

      it "returns the notes with the matching header" do
        expect(notes_value).to eq ["<p>Testing</p>"]
      end
    end
  end
end
