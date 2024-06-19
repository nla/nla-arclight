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

      it "returns nil" do
        expect(extents_information_value).to be_nil
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
        expect(notes_value).to be_nil
      end
    end

    context "when header literal contains punctuation" do
      subject(:notes_value) do
        document.extract_notes_by_header("biog_hist")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: ["{\"head\":\"Biographical / Historical\",\"p\":[\"Testing\",\"Testing 2\"],\"audience\":\"internal\"}"]
        )
      }

      it "returns the notes with the matching header" do
        expect(notes_value).to eq ["<p>Testing</p>", "<p>Testing 2</p>"]
      end
    end

    context "when there is a single note paragraph" do
      subject(:notes_value) do
        document.extract_notes_by_header("references")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: ["{\"head\":\"References\",\"p\":\"Testing\",\"audience\":\"internal\"}"]
        )
      }

      it "returns the notes with the matching header" do
        expect(notes_value).to eq ["<p>Testing</p>"]
      end
    end

    context "when there are multiple note paragraphs" do
      subject(:notes_value) do
        document.extract_notes_by_header("references")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: ["{\"head\":\"References\",\"p\":[\"Testing\", \"Testing 2\"],\"audience\":\"internal\"}"]
        )
      }

      it "returns the notes with the matching header" do
        expect(notes_value).to eq ["<p>Testing</p>", "<p>Testing 2</p>"]
      end
    end

    context "when note already contains HTML tags" do
      subject(:notes_value) do
        document.extract_notes_by_header("references")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: ["{\"head\":\"References\",\"p\":\"<p>Testing</p>\",\"audience\":\"internal\"}"]
        )
      }

      it "doesn't wrap the content again" do
        expect(notes_value).to eq ["<p>Testing</p>"]
      end
    end

    context "when note doesn't contains a chronlist" do
      subject(:notes_value) do
        document.extract_notes_by_header("biog")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: [
            "{\"head\":\"Biographical Note\",\"p\":{\"chronlist\":{\"listhead\":{\"head01\":\"Date\",\"head02\":\"Event\"},\"chronitem\":[{\"date\":1925,\"event\":\"Born in Yarram, Victoria, on 26 October\"},{\"date\":\"1942-1943\",\"event\":\"Student teacher, Department of Education, Victoria\"},{\"date\":\"1943-1946\",\"event\":\"Navigator, Royal Australian Air Force\"},{\"date\":1948,\"event\":\"Bachelor of Arts (Honours), University of Melbourne\"},{\"date\":\"1949-1951\",\"event\":\"Tutor in History, University of Melbourne\"},{\"date\":1951,\"event\":\"Master of Arts (Honours), University of Melbourne\"},{\"date\":\"\",\"event\":\"Inaugural Archbishop Mannix Travelling Scholar\"},{\"date\":\"1951-1953\",\"event\":\"Australian National University Research Scholar, University of Cambridge\"},{\"date\":1953,\"event\":\"Bachelor of Arts, University of Cambridge\"},{\"date\":\"1953-1958\",\"event\":\"Lecturer in History, University of Melbourne\"},{\"date\":\"1959-1964\",\"event\":\"Senior Lecturer in History, University of Melbourne\"},{\"date\":1960,\"event\":\"Master of Arts, University of Cambridge\"},{\"date\":1961,\"event\":\"Foundation Member, Australian Institute of Aboriginal Studies\"},{\"date\":\"\",\"event\":\"Nuffield Foundation Dominion Fellow, Institute of Archaeology (London)\"},{\"date\":1963,\"event\":\"Royal Society of Victoria Research Medal\"},{\"date\":\"1964-1980\",\"event\":\"Council Member, Australian Institute of Aboriginal Studies\"},{\"date\":\"1965-1970\",\"event\":\"Senior Fellow in Prehistory, Research School of Pacific Studies, Australian National University\"},{\"date\":\"1965-1976\",\"event\":\"Executive Member, Australian Institute of Aboriginal Studies\"},{\"date\":1969,\"event\":\"Australian Literature Society Dame Mary Gilmore Medal\"},{\"date\":1970,\"event\":\"Doctor of Philosophy, University of Cambridge\"},{\"date\":\"\",\"event\":\"Fellow, Australian Academy of the Humanities\"},{\"date\":1971,\"event\":\"Acting Principal, Australian Institute of Aboriginal Studies\"},{\"date\":\"1971-1985\",\"event\":\"Foundation Professor of Prehistory, Faculty of Arts, Australian National University\"},{\"date\":\"1972-1974\",\"event\":\"Council Member, Australian Academy of the Humanities\"},{\"date\":\"1972-1976\",\"event\":\"Deputy Chairman, Australian Institute of Aboriginal Studies\"},{\"date\":\"1974-1975\",\"event\":\"Member, Committee of Inquiry into Museums and National Collections\"},{\"date\":1975,\"event\":\"Chairman, Planning Committee, Gallery of Aboriginal Australia\"},{\"date\":\"1975-1976\",\"event\":\"Deputy Chairman, Museums Association, Canberra Division\"},{\"date\":\"1976-1977\",\"event\":\"Commonwealth Visiting Professor, University of Cambridge\"},{\"date\":\"1976-1982\",\"event\":\"Australian Heritage Commissioner\"},{\"date\":1977,\"event\":\"Fellow, Society of Antiquaries of London\"},{\"date\":1981,\"event\":\"President, Section 25A (Archaeology), ANZAAS Conference\"},{\"date\":\"1981-1983\",\"event\":\"Member, Interim Council of the Museum of Australia\"},{\"date\":1982,\"event\":\"Companion of the Order of St Michael and St George\"},{\"date\":\"1982-1984\",\"event\":\"Chairman, Australian Institute of Aboriginal Studies\"},{\"date\":1983,\"event\":\"Corresponding Fellow of the British Academy\"},{\"date\":\"1984-1985\",\"event\":\"Visiting Professor in Australian Studies, Harvard University\"},{\"date\":1985,\"event\":\"Whitely Book Award for biography, Royal Zoological Society (NSW)\"},{\"date\":1986,\"event\":\"Emeritus Professor of Prehistory, Australian National University\"},{\"date\":1986,\"event\":\"Honorary Member, Australian Archaeological Association\"},{\"date\":\"\",\"event\":\"Victorian Premier's Literary Award for Australian Studies (with J. H. Calaby)\"},{\"date\":\"1986-1988\",\"event\":\"Chairman, ACT Heritage Committee\"},{\"date\":\"1986-1990\",\"event\":\"Honorary Fellow, Department of History, Research School of Pacific Studies, Australian National University\"},{\"date\":\"1987-1990\",\"event\":\"Honorary Fellow, Museum of Victoria\"},{\"date\":1988,\"event\":\"ANZAAS Medal\"},{\"date\":\"1989-1992\",\"event\":\"Member, Editorial Board, Australian Institute of Aboriginal Studies\"},{\"date\":\"1989-1996\",\"event\":\"Secretary, Australian Academy of the Humanities\"},{\"date\":1990,\"event\":\"Honorary Member, Indo-Pacific Prehistory Association\"},{\"date\":\"\",\"event\":\"Honorary Member, Prehistoric Society (London)\"},{\"date\":1991,\"event\":\"Order of Australia\"},{\"date\":1996,\"event\":\"Honorary Fellow, Royal Anthropological Institute\"},{\"date\":\"1997-1998\",\"event\":\"Ashley Fellow, Trent University (Canada)\"},{\"date\":1999,\"event\":\"Grahame Clark Medal, British Academy\"},{\"date\":2001,\"event\":\"Australian Centenary Medal\"},{\"date\":2004,\"event\":\"Rhys Jones Medal, Australian Archaeological Association\"}]},\"bibref\":\"<a href=\\\"http://nla.gov.au/nla.cat-vn2823420\\\"><em>Prehistory to Politics : John Mulvaney, the humanities and the public intellectual</em></a>, edited by Tim Bonyhady and Tom Griffiths. Carlton South, Victoria : Melbourne University Press, 1996.\"}}"
          ]
        )
      }

      it "converts the Hash into JSON" do
        expect(notes_value[0]).to be_a(String)
        expect(JSON.parse(notes_value[0])["chronlist"]).not_to be_nil
        expect(JSON.parse(notes_value[0])["chronlist"]["listhead"]).not_to be_nil
        expect(JSON.parse(notes_value[0])["chronlist"]["chronitem"]).not_to be_nil
      end
    end
  end
end
