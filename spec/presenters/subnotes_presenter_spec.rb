# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubnotesPresenter, :presenter do
  subject(:presenter) { described_class.new(request_context, document, field_config, options) }

  let(:request_context) { double("View context", params: {x: "1"}, search_state: search_state, should_render_field?: true, blacklight_config: config) }
  let(:document) do
    SolrDocument.new(
      id: 1,
      note_json_ssm: [
        "{\"head\":\"Biographical Note\",\"p\":[\"Sir Edmund Barton (1849-1920) was the first Prime Minister of the Commonwealth of Australia, having previously been a leading advocate of Federation and one of the draftsmen of the Australian Constitution. He served as Prime Minister from 1 January 1901 until 23 September 1903, and then resigned to become the senior puisne judge of the newly-established High Court of Australia.\",\"Edmund Barton was the fourth and youngest son of William Barton (1795-1881) and Mary Louisa, née Whydah, who had emigrated from England to New South Wales in 1827. An elder brother was the barrister, journalist and author George B. Barton (1836-1901). On 28 December 1877 Edmund Barton married Jane (Jean) Mason Ross (1851-1938). Their children were Edmund Alfred (b. 1879), Wilfrid Alexander (b. 1880), Jean Alice (b. 1882), Arnold Hubert (b. 1884), Oswald (b. 1888) and Leila Stephanie (b. 1892).\",{\"chronlist\":{\"listhead\":{\"head01\":\"Date\",\"head02\":\"Event\"},\"chronitem\":[{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1849},\"event\":\"Born in Glebe, Sydney, 18 January\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1859-64\"},\"event\":\"Attended Sydney Grammar School\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1865-67\"},\"event\":\"Attended University of Sydney\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1870},\"event\":\"Graduated as a Master of Arts\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1871},\"event\":\"Called to Bar in Sydney\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1879-82\"},\"event\":\"Member of Legislative Assembly (University of Sydney seat)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1882-87\"},\"event\":\"Member of Legislative Assembly (seat of East Sydney)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1883-87\"},\"event\":\"Speaker of the Legislative Assembly\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1887-91\"},\"event\":\"Member of the Legislative Council\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1887},\"event\":\"Attorney-General in the Dibbs Protectionist Ministry\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1891},\"event\":\"New South Wales delegate at the Federal Convention in Sydney\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1891-94\"},\"event\":\"Member of the Legislative Assembly (East Sydney)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1891-92\"},\"event\":\"Attorney-General in the Dibbs Protectionist Ministry\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1894},\"event\":\"Defeated in the general election (seat of Randwick)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1894-97\"},\"event\":\"Led the Federation movement in New South Wales\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1897-98\"},\"event\":\"New South Wales delegate at the Australasian Federal Convention and chairman of the drafting and constitutional committees\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1897-98\"},\"event\":\"Member of the Legislative Council\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1898},\"event\":\"Defeated by George Reid in the general election (seat of Sydney (King Division))\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1898-1900\"},\"event\":\"Member of the Legislative Assembly (seat of Hastings and Macleay)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1899},\"event\":\"Leader of the Australian delegation to London\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1900},\"event\":\"Appointed first Prime Minister of Australia and Minister for External Affairs, 31 December\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1901},\"event\":\"Appointed a Privy Councillor, 24 January\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1901-3\"},\"event\":\"Member of the House of Representatives (seat of Hunter)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1902},\"event\":\"Attended Colonial Conference and Coronation of King Edward VII\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1902},\"event\":\"Knighted (GCMG)\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1903},\"event\":\"Resigned as Prime Minister, 23 September\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":\"1903-20\"},\"event\":\"Senior puisne justice of the High Court of Australia\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1915},\"event\":\"Visited England\"},{\"date\":{\"calendar\":\"gregorian\",\"era\":\"ce\",\"content\":1920},\"event\":\"Died at Medlow Bath, Blue Mountains, 7 January\"}]}}],\"audience\":\"internal\",\"chronlist\":{\"audience\":\"internal\",\"chronitem\":[{\"date\":1849,\"eventgrp\":{\"event\":\"Born in Glebe, Sydney, 18 January\"}},{\"date\":\"1859-64\",\"eventgrp\":{\"event\":\"Attended Sydney Grammar School\"}},{\"date\":\"1865-67\",\"eventgrp\":{\"event\":\"Attended University of Sydney\"}},{\"date\":1870,\"eventgrp\":{\"event\":\"Graduated as a Master of Arts\"}},{\"date\":1871,\"eventgrp\":{\"event\":\"Called to Bar in Sydney\"}},{\"date\":\"1879-82\",\"eventgrp\":{\"event\":\"Member of Legislative Assembly (University of Sydney seat)\"}},{\"date\":\"1882-87\",\"eventgrp\":{\"event\":\"Member of Legislative Assembly (seat of East Sydney)\"}},{\"date\":\"1883-87\",\"eventgrp\":{\"event\":\"Speaker of the Legislative Assembly\"}},{\"date\":\"1887-91\",\"eventgrp\":{\"event\":\"Member of the Legislative Council\"}},{\"date\":1887,\"eventgrp\":{\"event\":\"Attorney-General in the Dibbs Protectionist Ministry\"}},{\"date\":1891,\"eventgrp\":{\"event\":\"New South Wales delegate at the Federal Convention in Sydney\"}},{\"date\":\"1891-94\",\"eventgrp\":{\"event\":\"Member of the Legislative Assembly (East Sydney)\"}},{\"date\":\"1891-92\",\"eventgrp\":{\"event\":\"Attorney-General in the Dibbs Protectionist Ministry\"}},{\"date\":1894,\"eventgrp\":{\"event\":\"Defeated in the general election (seat of Randwick)\"}},{\"date\":\"1894-97\",\"eventgrp\":{\"event\":\"Led the Federation movement in New South Wales\"}},{\"date\":\"1897-98\",\"eventgrp\":{\"event\":\"New South Wales delegate at the Australasian Federal Convention and chairman of the drafting and constitutional committees\"}},{\"date\":\"1897-98\",\"eventgrp\":{\"event\":\"Member of the Legislative Council\"}},{\"date\":1898,\"eventgrp\":{\"event\":\"Defeated by George Reid in the general election (seat of Sydney (King Division))\"}},{\"date\":\"1898-1900\",\"eventgrp\":{\"event\":\"Member of the Legislative Assembly (seat of Hastings and Macleay)\"}},{\"date\":1899,\"eventgrp\":{\"event\":\"Leader of the Australian delegation to London\"}},{\"date\":1900,\"eventgrp\":{\"event\":\"Appointed first Prime Minister of Australia and Minister for External Affairs, 31 December\"}},{\"date\":1901,\"eventgrp\":{\"event\":\"Appointed a Privy Councillor, 24 January\"}},{\"date\":\"1901-3\",\"eventgrp\":{\"event\":\"Member of the House of Representatives (seat of Hunter)\"}},{\"date\":1902,\"eventgrp\":{\"event\":\"Attended Colonial Conference and Coronation of King Edward VII\"}},{\"date\":1902,\"eventgrp\":{\"event\":\"Knighted (GCMG)\"}},{\"date\":1903,\"eventgrp\":{\"event\":\"Resigned as Prime Minister, 23 September\"}},{\"date\":\"1903-20\",\"eventgrp\":{\"event\":\"Senior puisne justice of the High Court of Australia\"}},{\"date\":1915,\"eventgrp\":{\"event\":\"Visited England\"}},{\"date\":1920,\"eventgrp\":{\"event\":\"Died at Medlow Bath, Blue Mountains, 7 January\"}}]}}",
        "{\"head\":\"Container List\",\"p\":{\"table\":{\"tgroup\":{\"colspec\":{\"colwidth\":33},\"tbody\":{\"row\":[{\"entry\":[1,\"1-6\",1]},{\"entry\":[2,7,1]},{\"entry\":[2,\"8-12\",2]},{\"entry\":[2,\"13-15\",3]},{\"entry\":[2,\"16-19\",4]},{\"entry\":[2,\"20-26\",5]},{\"entry\":[2,\"27-34\",6]},{\"entry\":[3,35,7]},{\"entry\":[4,\"36-38\",7]},{\"entry\":[5,\"39-43\",7]},{\"entry\":[6,\"44-47\",8]},{\"entry\":[\"7A\",\"48-50\",8]},{\"entry\":[\"7B\",51,8]},{\"entry\":[\"7B\",\"52-53\",9]},{\"entry\":[\"7C\",\"54-55\",9]},{\"entry\":[8,\"56-57\",9]},{\"entry\":[9,\"59-60\",9]},{\"entry\":[9,61,10]},{\"entry\":[9,\"Folio 1\",\"Folio Run\"]},{\"entry\":[\"10A\",\"62-65\",10]},{\"entry\":[\"10A\",\"66-68\",11]},{\"entry\":[\"10B\",\"69-71\",11]},{\"entry\":[\"10B\",72,12]},{\"entry\":[\"10C\",\"73-78\",12]},{\"entry\":[\"10C\",\"Folio 4\",\"Folio Run\"]},{\"entry\":[11,\"79-84\",13]},{\"entry\":[11,\"printed material\",14]},{\"entry\":[11,\"printed material\",15]},{\"entry\":[11,\"Folio 2\",\"Folio Run\"]},{\"entry\":[12,\"85-88\",16]},{\"entry\":[13,\"89-90\",16]},{\"entry\":[13,\"Folio 3\",\"Folio Run\"]},{\"entry\":[14,91,16]},{\"entry\":[8,58,16]}]},\"thead\":{\"row\":{\"entry\":[\"Series\",\"File/Item\",\"Box\"]}},\"cols\":3}}}}"
      ]
    )
  end
  let(:options) { {} }
  let(:params) { {} }
  let(:controller) { double }
  let(:search_state) { Blacklight::SearchState.new(params, config, controller) }

  let(:field_config) { config.background_fields[field_name] }
  let(:config) do
    Blacklight::Configuration.define_field_access :background_field, Blacklight::Configuration::ShowField
    Blacklight::Configuration.new.configure do |config|
      config.add_background_field "biog",
        label: I18n.t("ead_notes.biog"),
        helper_method: :render_html_tags,
        presenter: described_class,
        values: ->(__field_config, document, _context) { document.extract_notes_by_header("biog") }
      config.add_background_field "container_list",
        label: I18n.t("ead_notes.container_list"),
        helper_method: :render_html_tags,
        presenter: described_class,
        values: ->(__field_config, document, _context) { document.extract_notes_by_header("container_list") }
    end
  end

  describe "#render" do
    subject(:rendered) { presenter.render }

    before do
      allow(request_context).to receive(:render_html_tags) do |params|
        ActionController::Base.helpers.render_html_tags(params)
      end
    end

    context "when it contains paragraphs" do
      let(:field_name) { "biog" }

      it "renders the subnote paragraphs" do
        expect(rendered).to include("<p>Sir Edmund Barton (1849-1920) was the first Prime Minister of the Commonwealth of Australia, having previously been a leading advocate of Federation and one of the draftsmen of the Australian Constitution. He served as Prime Minister from 1 January 1901 until 23 September 1903, and then resigned to become the senior puisne judge of the newly-established High Court of Australia.</p><p>Edmund Barton was the fourth and youngest son of William Barton (1795-1881) and Mary Louisa, née Whydah, who had emigrated from England to New South Wales in 1827. An elder brother was the barrister, journalist and author George B. Barton (1836-1901). On 28 December 1877 Edmund Barton married Jane (Jean) Mason Ross (1851-1938). Their children were Edmund Alfred (b. 1879), Wilfrid Alexander (b. 1880), Jean Alice (b. 1882), Arnold Hubert (b. 1884), Oswald (b. 1888) and Leila Stephanie (b. 1892).</p>")
      end
    end

    context "when it contains a chronlist" do
      let(:field_name) { "biog" }

      it "renders the chronlist table" do
        expect(rendered).to include('<table class="table table-light table-responsive table-striped table-hover">')
      end
    end

    context "when it contains a bibref" do
      let(:field_name) { "biog" }
      let(:document) do
        SolrDocument.new(
          id: 1,
          note_json_ssm: [
            "{\"head\":\"Biographical Note\",\"p\":[\"Known as Bill to his colleagues, Thomas William Bearup was closely connected with Australian broadcasting from its beginnings in 1923 until his death in 1980. He was awarded an OBE in recognition of his contribution to this field.\",\"Bearup was born in Hamilton, Victoria on 18 August 1897. In 1916 he joined the marine service of Amalgamated Wireless (Australasia) (AWA) as a wireless operator. After five years at sea, he was appointed to AWA's experimental wireless station at Koo-Wee-Rup in Victoria. When that station closed down in 1922, Bearup acted as AWA's Melbourne inspector. In 1923 he travelled to England where he continued to be involved in radio. Upon his return to Australia, he joined the Australian Broadcasting Company and was appointed Studio Manager of the Melbourne radio station, 3LO. In 1929, Bearup became Victorian Manager, a position he retained when the Australian Broadcasting Commission was established in 1932. Bearup's association with the ABC was to last thirty years. In 1936, he spent nine months overseas investigating the broadcasting scene in the United States and Great Britain. From 1937 to 1945, he served the ABC as Assistant General Manager and he was also Acting General Manager from 1940 to 1943 and in 1945. In 1946, Bearup was posted to London as the ABC's Overseas Representative and he held this position until his retirement from the ABC in 1962. As part of his duties he also visited the United States during this period. Bearup was Chairman of radio station 5DN (Adelaide) and a director of the Macquarie Broadcasting Services from 1964 to 1976.\",\"Bearup was also a Freeman and Liveryman of the Worshipful Company of Musicians of the City of London, a life member of the Radio Institute of Radio Engineers (U.S.) and, for 47 years, he was a member of Rotary clubs in Melbourne, Sydney, London and Adelaide. This long service was recognised when he was awarded the Paul Harris Fellowship just before his death. In 1925, he married Dorothy Watson and they had two daughters, Judith and Cecilie. Bearup's wife died in 1979 and he died a year later, at his home in the Adelaide suburb of Belair, on 15 June 1980, aged 82.\",{\"bibref\":[\"<em>Who's who in Australia</em>, 1977.\",\"Melbourne <em>Herald</em> and <em>Weekly Times</em>, 1977.\"]}]}"
          ]
        )
      end

      it "renders the bibref" do
        expect(rendered).to include("<li>Melbourne <em>Herald</em> and <em>Weekly Times</em>, 1977.</li>")
      end
    end

    context "when it contains a table" do
      let(:field_name) { "container_list" }

      it "renders the table" do
        expect(rendered).to include('<table class="table table-light table-responsive table-striped table-hover">')
      end
    end
  end
end
