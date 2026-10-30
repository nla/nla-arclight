# frozen_string_literal: true

require "rails_helper"
require "csv"
require "json"

RSpec.describe "Bookmarks", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before do
    stub_bookmark_documents
    sign_in user
    user.bookmarks.create!(document_id: "280011976", document_type: "SolrDocument")
    user.bookmarks.create!(document_id: "367300335367601811", document_type: "SolrDocument")
  end

  describe "GET /finding-aids/bookmarks/cite_all" do
    it "shows an empty-state message when there are no bookmarks" do
      user.bookmarks.delete_all
      get cite_all_bookmarks_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include(I18n.t("blacklight.bookmarks.no_bookmarks"))
      expect(response.body).not_to include('data-clipboard-target="source"')
      expect(WebMock).not_to have_requested(:get, /solr:8983/)
      expect(WebMock).not_to have_requested(:post, /solr:8983/)
    end

    it "lists every bookmark with its fields, data-doc-id and record URL" do
      get cite_all_bookmarks_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include(I18n.t("cite_all.title"))
      expect(response.body).to include(I18n.t("cite_all.copy_to_clipboard"))
      expect(response.body).to include("19th century currency items, c1868-1895")
      expect(response.body).to include("Diaries, 1929, 1934; loose diary pages")
      expect(response.body).to include("MS 1139")
      expect(response.body).to include("data-doc-id")
      expect(response.body).to include("280011976")
      expect(response.body).to include("/finding-aids/catalog/280011976")
    end
  end

  describe "GET /finding-aids/bookmarks/export" do
    it "downloads a CSV of all bookmarks" do
      get export_bookmarks_path(format: "csv")

      expect(response).to have_http_status(:success)
      expect(response.headers["Content-Type"]).to include("text/csv")
      expect(response.headers["Content-Disposition"]).to include('filename="bookmarks.csv"')

      rows = CSV.parse(response.body)
      expect(rows.length).to eq(3)
      expect(rows.first.first).to eq("Title")
      expect(rows.first).to include("Unit ID", "Repository", "Date")
      expect(rows.first.last).to eq("Record URL")
      expect(rows.first[-2]).to eq("data-doc-id")

      header = rows.first
      unit_ids = rows[1..].pluck(header.index("Unit ID")).sort
      expect(unit_ids).to eq(["1", "MS 1139"])

      doc_ids = rows[1..].pluck(header.index("data-doc-id")).sort
      expect(doc_ids).to eq(["280011976", "367300335367601811"])

      record_urls = rows[1..].pluck(header.index("Record URL")).map { |url| URI.parse(url).path }.sort
      expect(record_urls).to eq(["/finding-aids/catalog/280011976", "/finding-aids/catalog/367300335367601811"])
    end
  end

  describe "when the user is not logged in" do
    before { sign_out :user }

    it "redirects away from cite all" do
      get cite_all_bookmarks_path
      expect(response).to have_http_status(:found)
    end

    it "redirects away from the export" do
      get export_bookmarks_path(format: "csv")
      expect(response).to have_http_status(:found)
    end
  end

  private

  def stub_bookmark_documents
    doc = JSON.parse(IO.read("spec/files/solr/280011976.json"))
    component = JSON.parse(IO.read("spec/files/solr/367300335367601811.json"))
    body = {
      response: {
        numFound: 2, start: 0, docs: [doc["response"]["docs"].first, component["response"]["docs"].first]
      }
    }.to_json

    [:get, :post].each do |method|
      WebMock.stub_request(method, /solr:8983/)
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
          }
        )
        .to_return(status: 200, body: body, headers: {"Content-Type" => "application/json"})
    end
  end
end
