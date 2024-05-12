require "rails_helper"

RSpec.describe "Document components" do
  context "when at the collection level" do
    before do
      solr_response = IO.read("spec/files/solr/280011976.json")

      WebMock.stub_request(:get, /solr:8983/)
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
          }
        )
        .to_return(status: 200, body: solr_response, headers: {})
    end

    it "has correct tab title, including the collection prefix" do
      visit solr_document_path(id: "280011976")

      expect(page).to have_title(I18n.t("collection_prefix") + "19th century currency items, c1868-1895 - Finding Aids")
    end

    it "has correct title, including the collection prefix" do
      visit solr_document_path(id: "280011976")

      expect(page).to have_css("div.title-container h1", text: I18n.t("collection_prefix") + "19th century currency items, c1868-1895")
    end
  end
end
