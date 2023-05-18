# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#nla_catalogue_url" do
    subject(:nla_catalogue_url) { helper.nla_catalogue_url }

    before do
      request.env["HTTP_HOST"] = "catalogue.nla.gov.au"
    end

    it "returns the NLA catalogue URL" do
      expect(nla_catalogue_url).to eq "http://catalogue.nla.gov.au"
    end
  end
end
