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
    %w[apa mla harvard].each do |style|
      it "copies every bookmark using the #{style} citation choice" do
        get cite_all_bookmarks_path(style: style)

        expect(response).to have_http_status(:success)
        source = response.parsed_body.at_css('[data-clipboard-target="source"]')
        expect(source.text).to include("19th century currency items", "MS 1139", "National Library of Australia")
        expect(source.text).to include("Papers of J.M. Braga", "Diaries and notebooks", "Braga, J.M.")
        expect(source.text).to include("/finding-aids/catalog/280011976", "/finding-aids/catalog/367300335367601811")
        expect(source.text).not_to include("<p>")
      end
    end

    [nil, "object_id", "preferred", "metadata"].each do |style|
      it "rejects the unsupported citation style #{style.inspect}" do
        get cite_all_bookmarks_path(style: style)
        expect(response).to have_http_status(:bad_request)
      end
    end

    it "shows an empty-state message when there are no bookmarks" do
      user.bookmarks.delete_all
      get cite_all_bookmarks_path(style: "apa")

      expect(response).to have_http_status(:success)
      expect(response.body).to include(I18n.t("blacklight.bookmarks.no_bookmarks"))
      expect(response.body).not_to include('data-clipboard-target="source"')
      expect(WebMock).not_to have_requested(:get, /solr:8983/)
      expect(WebMock).not_to have_requested(:post, /solr:8983/)
    end

    it "copies every bookmark with its citation and record URL" do
      get cite_all_bookmarks_path(style: "apa")

      expect(response).to have_http_status(:success)
      expect(response.body).to include(I18n.t("cite_all.title"))
      expect(response.body).to include(I18n.t("citation.copy_all"))
      expect(response.body).to include("19th century currency items")
      expect(response.body).to include("Diaries, 1929, 1934; loose diary pages")
      expect(response.body).to include("MS 1139")
      expect(response.body).to include("280011976")
      expect(response.body).to include("/finding-aids/catalog/280011976")
    end
  end

  describe "GET /finding-aids/bookmarks" do
    it "offers all citation choices and both download formats" do
      get bookmarks_path

      expect(response).to have_http_status(:success)
      expect(CitationHelper::CITATION_FORMATS.keys).to eq(%w[apa mla harvard])
      CitationHelper::CITATION_FORMATS.each_key do |style|
        expect(response.parsed_body.at_css("a[href='#{cite_all_bookmarks_path(style: style)}']")).to be_present
      end
      %w[csv ris].each do |format|
        expect(response.parsed_body.at_css("a[href='#{export_bookmarks_path(format: format)}']")).to be_present
      end
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
      expect(rows.first.first(7)).to eq(["Bib ID", "Finding Aid ID", "Unit ID", "Creator", "Title", "Collection Title", "Online Version"])
      expect(rows.first).to include("Unit ID", "Repository", "Date")
      expect(rows.first.last).to eq("Record URL")
      expect(rows.first).not_to include("data-doc-id", "Online Resources")

      header = rows.first
      unit_ids = rows[1..].pluck(header.index("Unit ID")).sort
      expect(unit_ids).to eq(["1", "MS 1139"])

      doc_ids = rows[1..].pluck(header.index("Finding Aid ID")).sort
      expect(doc_ids).to eq(["280011976", "367300335367601811"])
      expect(rows[1..].pluck(header.index("Bib ID"))).to contain_exactly("1132324", "538326")
      expect(rows[1..].pluck(header.index("Repository"))).to all(eq("National Library of Australia"))

      record_urls = rows[1..].pluck(header.index("Record URL")).map { |url| URI.parse(url).path }.sort
      expect(record_urls).to eq(["/finding-aids/catalog/280011976", "/finding-aids/catalog/367300335367601811"])
    end

    it "downloads RIS with the finding-aid URL separate from the digital-resource URL" do
      get export_bookmarks_path(format: "ris")

      expect(response).to have_http_status(:success)
      expect(response.headers["Content-Type"]).to include("application/x-research-info-systems")
      expect(response.headers["Content-Disposition"]).to include('filename="bookmarks.ris"')
      expect(response.body.scan(/^TY  - MANSCPT$/).length).to eq(2)
      expect(response.body).to include("AN  - http://www.example.com/finding-aids/catalog/280011976")
      expect(response.body).to include("AN  - http://www.example.com/finding-aids/catalog/367300335367601811")
      expect(response.body).to include("UR  - https://nla.gov.au/nla.obj-280011976\n")
      expect(response.body).to include("N1  - Record URL: http://www.example.com/finding-aids/catalog/280011976\n")
      expect(response.body).to include("UR  - http://www.example.com/finding-aids/catalog/367300335367601811\n")
      expect(response.body).to include("N1  - Parent Conditions Governing Access: Available for research.")
    end

    it "keeps all resource URLs in RIS and only additional URLs in online-resource notes" do
      stub_bookmark_documents(overrides: {"digital_objects_ssm" => [
        {href: "https://example.org/first"}.to_json,
        {href: "https://example.org/second"}.to_json,
        {href: "https://example.org/third"}.to_json
      ]})

      get export_bookmarks_path(format: "ris")

      response.body.split("\n\n").each do |record|
        expect(record.lines.grep(/^UR  - /).map(&:chomp)).to eq([
          "UR  - https://example.org/first", "UR  - https://example.org/second", "UR  - https://example.org/third"
        ])
        expect(record.lines.grep(/^N1  - Online resource:/).map(&:chomp)).to eq([
          "N1  - Online resource: https://example.org/second", "N1  - Online resource: https://example.org/third"
        ])
      end
    end

    %w[csv ris].each do |format|
      it "exports empty #{format} bookmarks without querying Solr" do
        user.bookmarks.delete_all

        get export_bookmarks_path(format: format)

        expect(response).to have_http_status(:success)
        if format == "csv"
          expect(CSV.parse(response.body).length).to eq(1)
        else
          expect(response.body).to be_empty
        end
        expect(WebMock).not_to have_requested(:get, /solr:8983/)
        expect(WebMock).not_to have_requested(:post, /solr:8983/)
      end
    end
  end

  context "with bookmarks spanning multiple pages" do
    let(:ids) { ["280011976", "367300335367601811"] + (1..20).map { |number| "extra-#{number}" } }

    before do
      ids.drop(2).each { |id| user.bookmarks.create!(document_id: id, document_type: "SolrDocument") }
      stub_bookmark_documents(ids: ids)
    end

    %w[csv ris].each do |format|
      it "exports every bookmark as #{format}, not just the current page" do
        get export_bookmarks_path(format: format, per_page: 10, page: 2)

        expect(response).to have_http_status(:success)
        count = (format == "csv") ? CSV.parse(response.body).length - 1 : response.body.scan(/^TY  - /).length
        expect(count).to eq(22)
        expect(response.body).to include("extra-20")
        expect(WebMock).to have_requested(:any, /solr:8983/).with { |request|
          params = Rack::Utils.parse_nested_query([request.uri.query, request.body].compact.join("&"))
          params["rows"] == "22" && params["start"].to_i.zero?
        }
      end
    end

    it "cites every bookmark, not just the current page" do
      get cite_all_bookmarks_path(style: "apa", per_page: 10, page: 2)

      source = response.parsed_body.at_css('[data-clipboard-target="source"]')
      expect(source.text).to include("/finding-aids/catalog/extra-20")
      expect(source.text.scan("/finding-aids/catalog/").length).to eq(22)
      expect(WebMock).to have_requested(:any, /solr:8983/).with { |request|
        params = Rack::Utils.parse_nested_query([request.uri.query, request.body].compact.join("&"))
        params["rows"] == "22" && params["start"].to_i.zero?
      }
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

    it "redirects away from RIS export" do
      get export_bookmarks_path(format: "ris")
      expect(response).to have_http_status(:found)
    end
  end

  private

  def stub_bookmark_documents(overrides: {}, ids: nil)
    doc = JSON.parse(IO.read("spec/files/solr/280011976.json"))
    component = JSON.parse(IO.read("spec/files/solr/367300335367601811.json"))
    documents = [doc["response"]["docs"].first.merge(overrides), component["response"]["docs"].first.merge(overrides)]
    documents = ids.map { |id| documents.first.merge("id" => id) } if ids
    body = {
      response: {
        numFound: documents.length, start: 0, docs: documents
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
