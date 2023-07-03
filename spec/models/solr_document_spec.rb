# frozen_string_literal: true

require "rails_helper"

RSpec.describe SolrDocument do
  describe "#catalogue_link" do
    it "returns a link to the catalogue record" do
      doc = described_class.new(id: "123456", bibid_ssi: "123456")
      expect(doc.catalogue_link).to eq "https://nla.gov.au/nla.cat-vn123456"
    end
  end
end
