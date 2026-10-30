# frozen_string_literal: true

require "rails_helper"
require "csv"

RSpec.describe Nla::Exports::CsvExport do
  subject(:csv) { described_class.new([document], fields, url_proc).render }

  let(:fields) { CatalogController.blacklight_config.index_fields.to_h.except("highlight").values }
  let(:url_proc) { proc { |document| "https://test.host/finding-aids/catalog/#{document.id}" } }
  let(:document) do
    SolrDocument.new(
      id: "280011976",
      normalized_title_ssm: "19th century currency items",
      unitid_ssm: ["MS 1139"],
      repository_ssm: ["National Library of Australia"],
      normalized_date_ssm: ["c1868-1895"],
      scopecontent_ssm: ["<p>Banknotes and related material</p>"]
    )
  end

  def parsed
    CSV.parse(csv)
  end

  it "renders a header of title, the bookmarks-view fields, data-doc-id and record URL" do
    header = parsed.first
    expect(header.first).to eq("Title")
    expect(header).to include("Unit ID", "Repository", "Date")
    expect(header[-2]).to eq("data-doc-id")
    expect(header.last).to eq("Record URL")
  end

  it "renders one row per document" do
    expect(parsed.length).to eq(2)
  end

  it "neutralizes spreadsheet formulas in titles and field values" do
    ["=1+1", "+1+1", "-1+1", "@SUM(1)", "  =1+1", "\t=1+1"].each do |value|
      formula_document = SolrDocument.new(id: "1", normalized_title_ssm: value, unitid_ssm: [value])
      rows = CSV.parse(described_class.new([formula_document], fields, url_proc).render)
      expect(rows.last.first).to eq("'#{value}")
      expect(rows.last[rows.first.index("Unit ID")]).to eq("'#{value}")
    end
  end

  it "joins multi-valued fields with '; '" do
    document = SolrDocument.new(id: "1", normalized_title_ssm: "Title", unitid_ssm: ["MS 1", "MS 2"])
    csv = described_class.new([document], fields, url_proc).render
    header = CSV.parse(csv).first
    expect(CSV.parse(csv).last[header.index("Unit ID")]).to eq("MS 1; MS 2")
  end

  it "strips HTML tags from field values" do
    header = parsed.first
    expect(parsed.last[header.index("Scope Content")]).to eq("Banknotes and related material")
  end

  it "renders the data-doc-id and record URL" do
    header = parsed.first
    expect(parsed.last[header.index("data-doc-id")]).to eq("280011976")
    expect(parsed.last[header.index("Record URL")]).to eq("https://test.host/finding-aids/catalog/280011976")
  end

  it "renders an empty row for a document without data" do
    csv = described_class.new([SolrDocument.new(id: "1")], fields, url_proc).render
    header = CSV.parse(csv).first
    expect(CSV.parse(csv).last[header.index("Unit ID")]).to eq("")
    expect(CSV.parse(csv).last[header.index("Record URL")]).to eq("https://test.host/finding-aids/catalog/1")
  end
end
