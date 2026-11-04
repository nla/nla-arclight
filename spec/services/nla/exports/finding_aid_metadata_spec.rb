# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nla::Exports::FindingAidMetadata do
  subject(:metadata) { described_class.new(document) }

  let(:document) do
    SolrDocument.new(
      id: "file-1", title_ssm: ["Letters"], normalized_title_ssm: ["Letters, 1900-1901"],
      creator_ssm: ["Smith, Mary", "Smith, John"], normalized_date_ssm: ["1900", "1901"],
      unitid_ssm: ["MS 1", "File 2"], level_ssm: ["File"], repository_ssim: ["National Library of Australia"],
      parent_unittitles_ssm: ["Smith papers", "Correspondence"], containers_ssim: ["Box 1"],
      prefercite_html_tesm: ["<p>Smith &amp; family.</p><p>National Library.</p>"]
    )
  end

  it "keeps every creator, date and identifier without using single-value aliases" do
    expect(metadata.creators).to eq(["Smith, Mary", "Smith, John"])
    expect(metadata.dates).to eq(["1900", "1901"])
    expect(metadata.identifiers).to eq(["MS 1", "File 2"])
    expect(metadata.title).to eq("Letters")
    expect(metadata.repository).to eq("National Library of Australia")
  end

  it "retains the parent hierarchy and physical location for a component" do
    expect(metadata.context).to eq("Smith papers; Correspondence; MS 1; File 2; Box 1")
  end

  it "cleans supplied preferred citation markup without joining paragraphs or leaving entities" do
    expect(metadata.preferred_citation).to eq("Smith & family. National Library.")
  end

  context "with a collection" do
    let(:document) { SolrDocument.new(id: "1", level_ssm: ["Collection"], unitid_ssm: ["MS 1"], collection_ssim: ["Smith papers"]) }

    it "does not repeat the collection as its own ancestor" do
      expect(metadata.context).to eq("MS 1")
    end
  end

  context "with fallback fields only" do
    let(:document) do
      SolrDocument.new(id: "1", normalized_title_ssm: ["Untitled papers"], collection_creator_ssm: ["Smith family"],
        unitdate_ssm: ["circa 1900-1910"], collection_ssim: ["Family papers"])
    end

    it "uses supplied collection creators and archival dates without inventing exact dates" do
      expect(metadata.title).to eq("Untitled papers")
      expect(metadata.creators).to eq(["Smith family"])
      expect(metadata.dates).to eq(["circa 1900-1910"])
      expect(metadata.context).to eq("Family papers")
    end
  end

  context "with digital objects" do
    let(:document) do
      SolrDocument.new(id: "1", digital_objects_ssm: [
        {href: " https://example.org/first ", label: "First"}.to_json,
        "not json", "null", "[]", {href: 123}.to_json,
        {href: "https://example.org/first"}.to_json,
        {href: " "}.to_json, {label: "No link"}.to_json,
        {href: "ftp://example.org/second"}.to_json
      ])
    end

    it "keeps distinct nonblank hrefs in source order without restricting URI schemes" do
      allow(Rails.logger).to receive(:warn)
      expect(metadata.resource_urls).to eq(["https://example.org/first", "ftp://example.org/second"])
      expect(Rails.logger).to have_received(:warn).with("Finding aid export skipped invalid digital-object metadata")
    end
  end

  context "without metadata" do
    let(:document) { SolrDocument.new(id: "1") }

    it "returns empty values without making external requests" do
      expect(metadata.title).to eq("")
      expect(metadata.creators).to eq([])
      expect(metadata.dates).to eq([])
      expect(metadata.context).to eq("")
      expect(metadata.resource_urls).to eq([])
    end
  end
end
