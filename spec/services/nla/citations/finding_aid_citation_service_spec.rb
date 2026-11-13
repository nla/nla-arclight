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

  %w[apa harvard].each do |style|
    it "italicizes the archival title for #{style} without changing the citation text" do
      fragment = Nokogiri::HTML.fragment(service.render_html(style))
      expect(fragment.at_css("em").text).to eq("Letters")
      expect(fragment.text).to eq(service.render(style))
    end
  end

  it "italicizes the collection title, not the component title, for MLA" do
    fragment = Nokogiri::HTML.fragment(service.render_html("mla"))
    expect(fragment.at_css("em").text).to eq("Smith papers")
    expect(fragment.text).to eq(service.render("mla"))
  end

  context "when the title also appears in the creator's name" do
    let(:document) { SolrDocument.new(id: "1", title_ssm: ["Smith"], creator_ssm: ["Smith, Mary"], level_ssm: ["File"]) }

    %w[apa harvard].each do |style|
      it "emphasizes only the title in #{style}" do
        fragment = Nokogiri::HTML.fragment(service.render_html(style))
        expect(fragment.css("em").map(&:text)).to eq(["Smith"])
        expect(service.render_html(style)).to include("Smith, Mary")
        expect(service.render_html(style)).not_to start_with("<em>")
        expect(fragment.text).to eq(service.render(style))
      end
    end
  end

  context "with a top-level collection and a different normalized collection label" do
    let(:document) do
      SolrDocument.new(id: "1", title_ssm: ["Smith papers"], collection_ssim: ["Smith papers, 1900-1910"],
        normalized_date_ssm: ["1900-1910"], level_ssm: ["Collection"], unitid_ssm: ["MS 1"])
    end

    it "emphasizes the supplied title for MLA without changing the text" do
      fragment = Nokogiri::HTML.fragment(service.render_html("mla"))
      expect(fragment.css("em").map(&:text)).to eq(["Smith papers"])
      expect(fragment.text).to eq(service.render("mla"))
    end
  end

  context "when the collection title also appears in the component title" do
    let(:document) do
      SolrDocument.new(id: "1", title_ssm: ["Smith papers correspondence"], parent_unittitles_ssm: ["Smith papers"], level_ssm: ["File"])
    end

    it "emphasizes the collection context rather than part of the component title" do
      html = service.render_html("mla")
      expect(html).to include("“Smith papers correspondence.”")
      expect(html).to include("<em>Smith papers</em>.")
      expect(Nokogiri::HTML.fragment(html).text).to eq(service.render("mla"))
    end
  end

  it "rejects unsupported HTML citation styles" do
    expect { service.render_html("object_id") }.to raise_error(ArgumentError, "Unknown citation style")
  end

  context "with HTML-like text in the source metadata" do
    let(:document) { SolrDocument.new(id: "1", title_ssm: ["Fish &lt;script&gt;alert(1)&lt;/script&gt; &amp; chips"]) }

    it "escapes metadata instead of treating it as citation markup" do
      fragment = Nokogiri::HTML.fragment(service.render_html("apa"))
      expect(fragment.css("script")).to be_empty
      expect(fragment.at_css("em").text).to include("<script>alert(1)</script>", "& chips")
    end
  end

  context "without a creator or date" do
    let(:document) { SolrDocument.new(id: "1", title_ssm: ["Anonymous papers"]) }

    it "does not invent authors, dates or a repository" do
      expect(service.render("apa")).to eq("Anonymous papers [Archival material]. (n.d.). #{record_url}")
      expect(service.render("mla")).to eq("“Anonymous papers.” #{record_url}")
      expect(service.render("harvard")).to eq("n.d., Anonymous papers, #{record_url}")
    end

    %w[apa mla harvard].each do |style|
      it "keeps #{style} HTML text identical to the plain-text citation" do
        expect(Nokogiri::HTML.fragment(service.render_html(style)).text).to eq(service.render(style))
      end
    end
  end
end
