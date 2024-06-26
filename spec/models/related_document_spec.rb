# frozen_string_literal: true

require "rails_helper"

RSpec.describe RelatedDocument do
  subject(:related_document) { described_class.new(fas_attrs) }

  let(:fas_attrs) do
    {
      id: "nla.obj-367760674",
      copyRole: "fas",
      fileName: "Finding aid supplementary",
      externalComments: "Appendix C - Items in Series 12.1",
      fileType: "pdf",
      fileSize: 124305
    }
  end
  let(:non_fas_attrs) do
    {
      id: "nla.obj-594455512",
      copyRole: "te",
      fileName: "Electronic Transcript",
      externalComments: "",
      fileType: "doc",
      fileSize: 57
    }
  end

  it "converts a hash into an OpenStruct" do
    expect(related_document).not_to be_nil
    expect(related_document.is_a?(OpenStruct)).to be true
  end

  it "does not convert non-hash objects into an OpenStruct" do
    expect { described_class.new("string") }.to raise_error(NoMethodError)
  end

  it "has the file type in the link text" do
    expect(related_document.link_text).to include("Type: pdf")
  end

  it "has the file size in the link text" do
    expect(related_document.link_text).to include("Size: 121.39 KB")
  end

  context "when copyRole is 'fas'" do
    subject(:related_document) { described_class.new(fas_attrs) }

    it "contains 'Supplementary finding aid' in the link text" do
      expect(related_document.link_text).to include("Supplementary finding aid")
    end

    it "has the 'copyId' parameter in the download URL" do
      expect(related_document.download_url).to include("&copyId=")
    end
  end

  context "when copyRole is not 'fas'" do
    subject(:related_document) { described_class.new(non_fas_attrs) }

    it "contains 'Transcript' in the link text" do
      expect(related_document.link_text).to include("Transcript")
    end

    it "does not have the 'copyId' parameter in the download URL" do
      expect(related_document.download_url).not_to include("&copyId=")
    end
  end
end
