# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nla::Citations::FindingAidCitationService do
  subject(:service) { described_class.new(document, record_url) }

  let(:record_url) { "https://example.org/finding-aids/catalog/file-1" }
  let(:document) do
    SolrDocument.new(id: "file-1", title_ssm: ["Letters"], creator_ssm: ["Smith, Mary", "Smith, John"],
      normalized_date_ssm: ["circa 1900-1910"], level_ssm: ["File"], unitid_ssm: ["MS 1", "File 2"],
      parent_unittitles_ssm: ["Smith papers", "Correspondence"], repository_ssm: ["National Library of Australia"])
  end

  it "generates an APA archival citation with collection and item context" do
    expect(service.render("apa")).to eq(
      "Smith, Mary; Smith, John (circa 1900-1910). Letters [File]. Smith papers; Correspondence; MS 1; File 2. National Library of Australia. #{record_url}"
    )
  end

  it "generates an MLA archival citation" do
    expect(service.render("mla")).to eq(
      "Smith, Mary; Smith, John. “Letters.” circa 1900-1910. Smith papers; Correspondence; MS 1; File 2. National Library of Australia. #{record_url}"
    )
  end

  it "generates an Australian/Harvard archival citation" do
    expect(service.render("harvard")).to eq(
      "Smith, Mary; Smith, John circa 1900-1910, Letters, Smith papers; Correspondence; MS 1; File 2, National Library of Australia, #{record_url}"
    )
  end

  it "rejects unknown styles rather than dispatching arbitrary methods" do
    expect { service.render("object_id") }.to raise_error(ArgumentError, "Unknown citation style")
  end

  context "without a creator or date" do
    let(:document) { SolrDocument.new(id: "1", title_ssm: ["Anonymous papers"]) }

    it "does not invent authors, dates or a repository" do
      expect(service.render("apa")).to eq("Anonymous papers [Archival material]. (n.d.). #{record_url}")
      expect(service.render("mla")).to eq("“Anonymous papers.” #{record_url}")
      expect(service.render("harvard")).to eq("n.d., Anonymous papers, #{record_url}")
    end
  end
end
