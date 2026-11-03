# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nla::Exports::RisExport do
  subject(:ris) { described_class.new(documents, url_proc).render }

  let(:documents) { [document] }
  let(:url_proc) { proc { |doc| "https://example.org/finding-aids/catalog/#{doc.id}" } }
  let(:document) do
    SolrDocument.new(id: "file-1", title_ssm: ["Letters"], creator_ssm: ["Smith, Mary", "Smith, John"],
      normalized_date_ssm: ["circa 1900-1910"], repository_ssim: ["National Library of Australia"],
      unitid_ssm: ["MS 1", "File 2"], parent_unittitles_ssm: ["Smith papers", "Correspondence"],
      prefercite_html_tesm: ["<p>Supplied preferred citation.</p>"],
      scopecontent_ssm: ["<p>Letters &amp; notes.</p>"], userestrict_html_tesm: ["Permission required."],
      parent_access_restrict_tesm: ["Available for research."],
      digital_objects_ssm: [
        {href: "https://example.org/first"}.to_json,
        {href: " https://example.org/first "}.to_json,
        {href: "https://example.org/second"}.to_json,
        {href: "https://example.org/third"}.to_json
      ])
  end

  it "maps archival metadata without pretending it is a MARC catalogue record" do
    expect(ris).to start_with("TY  - MANSCPT\n")
    expect(ris.lines.grep(/^AU  - /)).to eq(["AU  - Smith, Mary\n", "AU  - Smith, John\n"])
    expect(ris).to include("TI  - Letters\n", "DA  - circa 1900-1910\n", "DB  - National Library of Australia\n", "CN  - MS 1; File 2\n")
    expect(ris).to include("AB  - Letters & notes.\n", "AN  - https://example.org/finding-aids/catalog/file-1\n")
    expect(ris).not_to include("nla.cat-vn")
    expect(ris).to end_with("ER  - \n\n")
  end

  it "keeps all distinct resource URLs in UR and only additional URLs in fallback notes" do
    expect(ris.lines.grep(/^UR  - /)).to eq([
      "UR  - https://example.org/first\n", "UR  - https://example.org/second\n", "UR  - https://example.org/third\n"
    ])
    expect(ris.lines.grep(/^N1  - Online resource:/)).to eq([
      "N1  - Online resource: https://example.org/second\n", "N1  - Online resource: https://example.org/third\n"
    ])
  end

  it "preserves archival context, supplied citation and rights without inferring copyright" do
    expect(ris).to include("N1  - Archival context: Smith papers; Correspondence; MS 1; File 2\n")
    expect(ris).to include("N1  - Preferred citation: Supplied preferred citation.\n")
    expect(ris).to include("N1  - Conditions Governing Use: Permission required.\n")
    expect(ris).to include("N1  - Parent Conditions Governing Access: Available for research.\n")
    expect(ris).not_to include("In Copyright", "Out of Copyright")
  end

  context "with one resource URL" do
    let(:document) { SolrDocument.new(id: "1", digital_objects_ssm: [{href: "https://example.org/only"}.to_json]) }

    it "does not duplicate the first URL in notes" do
      expect(ris.lines.grep(/^UR  - /)).to eq(["UR  - https://example.org/only\n"])
      expect(ris.lines.grep(/^N1  - Online resource:/)).to be_empty
    end
  end

  context "with missing metadata and no digital resources" do
    let(:document) { SolrDocument.new(id: "1") }

    it "retains the record URL without inventing other fields" do
      expect(ris).to eq("TY  - MANSCPT\nAN  - https://example.org/finding-aids/catalog/1\nER  - \n\n")
    end
  end

  context "with an embedded newline in a URL" do
    let(:document) { SolrDocument.new(id: "1", digital_objects_ssm: [{href: "https://example.org/\nAU  - Fake"}.to_json]) }

    it "does not allow data to create new RIS tags" do
      expect(ris.lines.grep(/^AU  - /)).to be_empty
      expect(ris).to include("UR  - https://example.org/ AU  - Fake\n")
    end
  end

  context "with multiple documents" do
    let(:documents) { [document, SolrDocument.new(id: "2")] }

    it "separates records without leaking resource URLs or notes between them" do
      records = ris.split("\n\n")
      expect(records.length).to eq(2)
      expect(records.last).to eq("TY  - MANSCPT\nAN  - https://example.org/finding-aids/catalog/2\nER  - ")
    end
  end

  context "without bookmarks" do
    let(:documents) { [] }

    it "renders an empty download" do
      expect(ris).to eq("")
    end
  end
end
