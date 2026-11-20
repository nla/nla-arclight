require "rails_helper"

RSpec.describe "Document components" do
  context "when at the collection level" do
    let(:solr_response) { IO.read("spec/files/solr/280011976.json") }

    before do
      WebMock.stub_request(:get, /solr:8983/)
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
          }
        )
        .to_return(status: 200, body: solr_response, headers: {})

      cat_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")

      WebMock.stub_request(:get, /catalogue-services\/folio\/instance\/(.*)/)
        .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
    end

    it "has correct tab title, including the collection prefix" do
      visit solr_document_path(id: "280011976")

      expect(page).to have_title(I18n.t("collection_prefix") + "19th century currency items, c1868-1895 | Finding Aids")
    end

    it "has correct title, including the collection prefix" do
      visit solr_document_path(id: "280011976")

      expect(page).to have_css("div.title-container h1", text: I18n.t("collection_prefix") + "19th century currency items, c1868-1895")
    end

    context "without a FOLIO instance ID" do
      let(:solr_response) do
        response = JSON.parse(super())
        response.dig("response", "docs").first.delete("folio_instance_id_ssi")
        response.to_json
      end

      it "renders the record without requesting holdings" do
        visit solr_document_path(id: "280011976")

        expect(page).to have_css("div.title-container h1", text: "19th century currency items, c1868-1895")
        expect(WebMock).not_to have_requested(:get, %r{/catalogue-services/folio/instance/})
      end
    end
  end
end
