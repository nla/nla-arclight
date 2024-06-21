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

    context "when note starts with an HTML tag" do
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

    context "when note doesn't start with an HTML tag and contains HTML" do
      subject(:notes_value) do
        document.extract_notes_by_header("references")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: ["{\"head\":\"References\",\"p\":\"Testing <em>HTML</em> inside a paragraph.\",\"audience\":\"internal\"}"]
        )
      }

      it "wraps the note in a paragraph and doesn't escape the existing markup" do
        expect(notes_value).to eq ["<p>Testing <em>HTML</em> inside a paragraph.</p>"]
      end
    end

    context "when chronlist is outside of the Text subnote" do
      subject(:notes_value) do
        document.extract_notes_by_header("biog")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: [
            "{\"head\":\"Biographical Note\",\"p\":[\"Margaret (Peggy) van Praagh was born in London in 1910. Her father, Harold John van Praagh, a doctor of Dutch-Jewish descent had established a successful practice in the Hampstead district.\",\"In 1916, while on summer holidays in Paignton, Devon, van Praagh appeared in a children's talent competition. She won first prize and was invited back to appear in the evening performance along with professional actors. In August of 1917, she appeared at the Torquay Pavilion and received her first press notice.\",\"From the age of seven she attended King Alfred School, Hampstead, where she was to complete her formal education and develop her creative talents. She combined her lessons in dancing with private lessons in piano and elocution. On finishing school van Praagh decided to commit herself to a life of dance.\",\"She continued training and in 1930 opened her first dance school. Around this time she began studying with Margaret Craske who introduced her to the Cecchetti Method of dance. She began studying and taking exams and became a qualified teacher of the Cecchetti Method.\",\"In 1933, she was invited by Marie Rambert to join her company, the Ballet Club, (later Ballet Rambert) which at that time was giving Sunday night performances at the small Mercury Theatre in London. The dancers were not paid for these performances and so van Praagh supported herself by teaching ballet to children. She remained with the Ballet Rambert until 1938, and was then a principal with the London Ballet in 1938-1940. In wartime London, ballet had to struggle to survive. London's famous lunch-hour series 'Ballet for a Bob' by the London Ballet was her brainchild.\",\"In 1941 van Praagh joined the Sadler's Wells Ballet. Her most notable roles with the company included Swanilda in <em>Coppelia</em> and the Blue Girl in <em>Les Patineurs</em>. She was also assigned to take company classes as well as private lessons to the principals who at that time included Margot Fonteyn, Robert Helpmann and Moira Shearer.\",\"In 1946 the Sadler's Wells Trust formed a second company known as the Sadler's Wells Theatre Ballet. Van Praagh became the company's Ballet Mistress and Producer. In 1951 she was appointed Assistant Director to Ninette de Valois and remained in this capacity until December 1956. During this period the company toured Great Britain, Europe, Rhodesia and South Africa in addition to giving its regular London seasons.\",\"On leaving the company, at the end of 1956, she became a freelance teacher, lecturer and producer of British ballet overseas. She produced Ninette de Valois' <em>The rake's progress</em> in Munich for the Bavarian State Opera Company, Frederick Ashton's <em>Les rendevous</em> for the National Ballet of Canada, <em>The sleeping beauty</em> for the Royal Danish Ballet in Copenhagen and Tudor's <em>Gala performance</em> for the Royal Swedish Ballet in Stockholm.\",\"In 1958 she became Dance Director for the Edinburgh Festival Ballet, which appeared at the Festival in August of that year. In a three week season, twelve new ballets by twelve new companies were produced.\",\"In 1959 she visited the United States of America and taught at Ted Shawn's Jacob Pillow as well as examining and giving master classes in many states.\",\"In December 1959, van Praagh was invited to direct the Borovansky Ballet in Australia and became its Artistic Director in its last two years. She did this with great success, staging <em>Rendevous</em> and the three-act <em>Coppelia</em>. After the final performance, she addressed the audience, and encouraged them to prevail upon the Australian Government to raise money for an Australian Ballet. Harold Holt, then Federal Treasurer, approached van Praagh after the show and pledged his personal support. The Australian Ballet was launched in 1962.\",\"Van Praagh was Artistic Director of the Australian Ballet in 1962-1974 and again in 1978. During this time she led the company on several exceptionally successful overseas tours, expanded the company's repertoire with a series of commissioned works from notable Australians and overseas choreographers, and invited guest artists of the stature of Margot Fonteyn and Rudolph Nureyev to perform with the company.\",\"On leaving the Australian Ballet she maintained an active role in ballet in Australia. She was a founding member of the Australian Association for Dance in Education and one of its chief architects, and she was a member of the Theatre Board of the Australia Council. Dame Peggy van Praagh died in Melbourne in 1990.\",{\"bibref\":{\"persname\":\"Sexton, Christopher\",\"content\":\"<span class='persname'>Sexton, Christopher</span>. <a href=\\\"http://nla.gov.au/nla.cat-vn1619352\\\"><em>Peggy van Praagh, a life of dance</em>.</a> South Melbourne : Macmillan, 1985.\"}}],\"chronlist\":{\"head\":\"Honours and Awards\",\"chronitem\":[{\"date\":1965,\"eventgrp\":{\"event\":\"The Queen Elizabeth Award - Royal Academy of Dancing, London\"}},{\"date\":1966,\"eventgrp\":{\"event\":\"Order of the British Empire (OBE) for services to ballet\"}},{\"date\":1970,\"eventgrp\":{\"event\":\"Dame Commander of the Order of the British Empire (DBE) for services to ballet\"}},{\"date\":1970,\"eventgrp\":{\"event\":\"Encyclopaedia Britannica (Australia) Award for the Arts\"}},{\"date\":1974,\"eventgrp\":{\"event\":\"Doctor of Letters (Honoris Causa) University of New England\"}},{\"date\":1975,\"eventgrp\":{\"event\":\"Distinguished Artist Award from the Australia Council\"}},{\"date\":1981,\"eventgrp\":{\"event\":\"Doctor of Laws (Honoris Causa) Melbourne University\"}}]}}"
          ]
        )
      }

      it "converts the Hash into JSON" do
        expect(notes_value.find { |note| note.is_a?(String) && note.include?("chronlist") }).not_to be_nil
      end
    end

    context "when chronlist outside of the Text subnote is an array" do
      subject(:notes_value) do
        document.extract_notes_by_header("biog")
      end

      let(:document) {
        described_class.new(
          note_json_ssm: [
            "{\"head\":\"Biographical Note\",\"p\":\"Loos, Noel and Mabo, Koiki. Edward Koiki Mabo: his life and struggle for land rights. Brisbane : University of Queensland Press, 1996.\",\"chronlist\":[{\"listhead\":{\"head01\":\"Date\",\"head02\":\"Event\"},\"chronitem\":[{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"29 June 1936\"},\"event\":\"Born on Mer, the son of Robert Zezou [1] Sambo and Annie Mabo of the Piadaram clan. Because his mother died in childbirth, he was adopted under customary law by his uncle Benny Mabo and aunt Maiga.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1953-1957\"},\"event\":\"Worked on various trochus fishing luggers out of Mer.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1957},\"event\":\"Left Mer and moved to the mainland. Subsequently worked at various jobs including canecutter and railway labourer.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1959},\"event\":\"Married Bonita Nehow (born 1943).\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1960-1961\"},\"event\":\"Union representative, Townsville-Mount Isa rail construction project.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1962-1967\"},\"event\":\"Worked for the Townsville Harbour Board.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1962-1969\"},\"event\":\"Secretary, Aboriginal and Torres Strait Islander Advancement League.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1967},\"event\":\"Helped organise seminar in Townsville: 'We the Australians: What is to Follow the Referendum?'\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1967-1971\"},\"event\":\"Worked as gardener-groundsman, James Cook University.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1970},\"event\":\"Resigned from the Aboriginal and Torres Strait Islander Advancement League because of the involvement of people he considered to be insincere 'do-gooders'. Became President of the all-black Council for the Rights of Indigenous People, which established a legal aid service, a medical service, and the Black Community School.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1973},\"event\":\"Mabo and family travelled to Thursday Island en route to Mer with the intention of visiting Mabo's dying father, but were denied entry to Mer.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1973-1983\"},\"event\":\"Director, Black Community School, Townsville.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1974-1987\"},\"event\":\"Member of the Aboriginal Arts Council.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1975-1980\"},\"event\":\"President, Yumba Meta Housing Association.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1975-1978\"},\"event\":\"Member, National Aboriginal Education Committee.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1978-1981\"},\"event\":\"Assistant Vocational Officer, Aboriginal Employment and Training Branch Commonwealth Employment Service.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1978-1979\"},\"event\":\"Member, Australian Institute of Aboriginal Studies Education Advisory Committee.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1981},\"event\":\"Conference on land rights at James Cook University. Decision made to take the Murray Islanders' land case to the High Court.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1981-1984\"},\"event\":\"Pursued Diploma of Teaching, Townsville College of Advanced Education/James Cook University.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1982},\"event\":\"Land rights case launched. Plaintiffs were Mabo, Sam Passi, Father Dave Passi, James Rice and Celuia Mapo Salee.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1985},\"event\":\"Field Officer, QED Townsville Aboriginal Legal Aid Service. Received a research grant from the Australian Institute of Aboriginal Studies to study land tenure in Torres Strait. In an attempt to retrospectively abolish native land title in Torres Strait, the Queensland Government passed the Queensland Coast Islands Declaratory Act 1985.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1986-1987\"},\"event\":\"Director, ABIS Community Cooperative Society Ltd, Townsville.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1986-1987\"},\"event\":\"Assistant Director, Aboriginal Arts, Melbourne Moomba Festival.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1987-1988\"},\"event\":\"Employed by the Department of Aboriginal Affairs as Community Arts Liaison Officer, 5th Festival of Pacific Arts, Townsville.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1987-1988\"},\"event\":\"Vice-Chairman, Magani Malu Kes.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1988},\"event\":\"High Court ruled the Queensland Coast Islands Declaratory Act 1985 contrary to the Commonwealth Racial Discrimination Act 1975.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"21 January 1992\"},\"event\":\"Edward Koiki Mabo died in Brisbane.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"3 June 1992\"},\"event\":\"High Court delivered a 6:1 verdict in favour of Mabo, Mabo v State of Queensland (No. 2) (1992) 175 CLR 1, overturning the 205-year-old legal doctrine of terra nullius.\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"26 January 1993\"},\"event\":\"<em>The Australian</em> announced Eddie Mabo its 1992 Australian of the Year.\"}]},{\"chronitem\":[{\"datesingle\":\"29 June 1936\",\"chronitemset\":{\"event\":\"Born on Mer, the son of Robert Zezou [1] Sambo and Annie Mabo of the Piadaram clan. Because his mother died in childbirth, he was adopted under customary law by his uncle Benny Mabo and aunt Maiga.\"}},{\"datesingle\":\"1953-1957\",\"chronitemset\":{\"event\":\"Worked on various trochus fishing luggers out of Mer.\"}},{\"datesingle\":1957,\"chronitemset\":{\"event\":\"Left Mer and moved to the mainland. Subsequently worked at various jobs including canecutter and railway labourer.\"}},{\"datesingle\":1959,\"chronitemset\":{\"event\":\"Married Bonita Nehow (born 1943).\"}},{\"datesingle\":\"1960-1961\",\"chronitemset\":{\"event\":\"Union representative, Townsville-Mount Isa rail construction project.\"}},{\"datesingle\":\"1962-1967\",\"chronitemset\":{\"event\":\"Worked for the Townsville Harbour Board.\"}},{\"datesingle\":\"1962-1969\",\"chronitemset\":{\"event\":\"Secretary, Aboriginal and Torres Strait Islander Advancement League.\"}},{\"datesingle\":1967,\"chronitemset\":{\"event\":\"Helped organise seminar in Townsville: 'We the Australians: What is to Follow the Referendum?'\"}},{\"datesingle\":\"1967-1971\",\"chronitemset\":{\"event\":\"Worked as gardener-groundsman, James Cook University.\"}},{\"datesingle\":1970,\"chronitemset\":{\"event\":\"Resigned from the Aboriginal and Torres Strait Islander Advancement League because of the involvement of people he considered to be insincere 'do-gooders'. Became President of the all-black Council for the Rights of Indigenous People, which established a legal aid service, a medical service, and the Black Community School.\"}},{\"datesingle\":1973,\"chronitemset\":{\"event\":\"Mabo and family travelled to Thursday Island en route to Mer with the intention of visiting Mabo's dying father, but were denied entry to Mer.\"}},{\"datesingle\":\"1973-1983\",\"chronitemset\":{\"event\":\"Director, Black Community School, Townsville.\"}},{\"datesingle\":\"1974-1987\",\"chronitemset\":{\"event\":\"Member of the Aboriginal Arts Council.\"}},{\"datesingle\":\"1975-1980\",\"chronitemset\":{\"event\":\"President, Yumba Meta Housing Association.\"}},{\"datesingle\":\"1975-1978\",\"chronitemset\":{\"event\":\"Member, National Aboriginal Education Committee.\"}},{\"datesingle\":\"1978-1981\",\"chronitemset\":{\"event\":\"Assistant Vocational Officer, Aboriginal Employment and Training Branch Commonwealth Employment Service.\"}},{\"datesingle\":\"1978-1979\",\"chronitemset\":{\"event\":\"Member, Australian Institute of Aboriginal Studies Education Advisory Committee.\"}},{\"datesingle\":1981,\"chronitemset\":{\"event\":\"Conference on land rights at James Cook University. Decision made to take the Murray Islanders' land case to the High Court.\"}},{\"datesingle\":\"1981-1984\",\"chronitemset\":{\"event\":\"Pursued Diploma of Teaching, Townsville College of Advanced Education/James Cook University.\"}},{\"datesingle\":1982,\"chronitemset\":{\"event\":\"Land rights case launched. Plaintiffs were Mabo, Sam Passi, Father Dave Passi, James Rice and Celuia Mapo Salee.\"}},{\"datesingle\":1985,\"chronitemset\":{\"event\":\"Field Officer, QED Townsville Aboriginal Legal Aid Service. Received a research grant from the Australian Institute of Aboriginal Studies to study land tenure in Torres Strait. In an attempt to retrospectively abolish native land title in Torres Strait, the Queensland Government passed the Queensland Coast Islands Declaratory Act 1985.\"}},{\"datesingle\":\"1986-1987\",\"chronitemset\":{\"event\":\"Director, ABIS Community Cooperative Society Ltd, Townsville.\"}},{\"datesingle\":\"1986-1987\",\"chronitemset\":{\"event\":\"Assistant Director, Aboriginal Arts, Melbourne Moomba Festival.\"}},{\"datesingle\":\"1987-1988\",\"chronitemset\":{\"event\":\"Employed by the Department of Aboriginal Affairs as Community Arts Liaison Officer, 5th Festival of Pacific Arts, Townsville.\"}},{\"datesingle\":\"1987-1988\",\"chronitemset\":{\"event\":\"Vice-Chairman, Magani Malu Kes.\"}},{\"datesingle\":1988,\"chronitemset\":{\"event\":\"High Court ruled the Queensland Coast Islands Declaratory Act 1985 contrary to the Commonwealth Racial Discrimination Act 1975.\"}},{\"datesingle\":\"21 January 1992\",\"chronitemset\":{\"event\":\"Edward Koiki Mabo died in Brisbane.\"}},{\"datesingle\":\"3 June 1992\",\"chronitemset\":{\"event\":\"High Court delivered a 6:1 verdict in favour of Mabo, Mabo v State of Queensland (No. 2) (1992) 175 CLR 1, overturning the 205-year-old legal doctrine of terra nullius.\"}},{\"datesingle\":\"26 January 1993\",\"chronitemset\":{\"event\":\"<em>The Australian</em> announced Eddie Mabo its 1992 Australian of the Year.\"}}]}]}"
          ]
        )
      }

      it "doesn't throw an exception" do
        expect { notes_value }.not_to raise_error
      end
    end
  end
end
