require "rails_helper"

RSpec.describe Requests::Catalogue do
  subject(:catalogue_request) { described_class.new(document) }

  let(:document) { SolrDocument.new(bibid_ssi: "123456", repository_ssm: ["National Library of Australia"]) }

  describe "#request_config" do
    it "returns the request config for the catalogue type" do
      expect(catalogue_request.request_config).to eq "request_url" => "https://nla.gov.au/nla.cat-vn%s"
    end
  end

  describe "#url" do
    it "returns a URL to the catalogue record" do
      expect(catalogue_request.url).to eq "https://nla.gov.au/nla.cat-vn123456"
    end
  end
end
