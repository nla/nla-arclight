# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Related Documents" do
  describe "when at the collection level" do
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

      availability_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")

      WebMock.stub_request(:get, /catalogue-services\/folio\/instance\/(.*)/)
        .to_return(status: 200, body: availability_response, headers: {"Content-Type" => "application/json"})
    end

    context "when there are related documents" do
      before do
        docs_response = IO.read("spec/files/catalogue_services/related_docs.json")
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/ead\/relateddocs\/(nla.obj-[0-9]*)/)
          .to_return(status: 200, body: docs_response, headers: {"Content-Type" => "application/json"})
      end

      it "renders the related documents" do
        visit solr_document_path(id: "280011976")

        expect(page).to have_css("h3", text: "Related")
        expect(page).to have_css("ol#related-documents")
        expect(page).to have_css("ol#related-documents li", count: 4)
      end
    end

    context "when there are no related documents" do
      before do
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/ead\/relateddocs\/(nla.obj-[0-9]*)/)
          .to_return(status: 200, body: "", headers: {"Content-Type" => "application/json"})
      end

      it "does not render the related documents" do
        visit solr_document_path(id: "280011976")
        # rubocop:disable Capybara/NegationMatcherAfterVisit
        expect(page).to have_no_css("h3", text: "Related")
        expect(page).to have_no_css("ol#related-documents")
        expect(page).to have_no_css("ol#related-documents li")
        # rubocop:enable Capybara/NegationMatcherAfterVisit
      end
    end
  end
end
