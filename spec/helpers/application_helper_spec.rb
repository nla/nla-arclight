# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#eresources_link_url" do
    subject(:url) { helper.eresources_link_url }

    context "when user is not logged in" do
      before do
        allow(helper).to receive(:current_user).and_return(nil)
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("EBSCO_ERESOURCES_URL").and_return(nil)
        allow(ENV).to receive(:fetch).and_call_original
      end

      it "returns the default guest URL" do
        expect(url).to eq "https://www.nla.gov.au/eresources"
      end

      it "returns the configured guest URL when ERESOURCES_GUEST_URL is set" do
        allow(ENV).to receive(:fetch).with("ERESOURCES_GUEST_URL", "https://www.nla.gov.au/eresources")
          .and_return("https://custom-guest.example.com/eresources")

        expect(url).to eq "https://custom-guest.example.com/eresources"
      end
    end

    context "when user is logged in with EBSCO_ERESOURCES_URL configured" do
      let(:user) { create(:user) }

      before do
        allow(helper).to receive(:current_user).and_return(user)
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("EBSCO_ERESOURCES_URL")
          .and_return("https://research.ebsco.com/c/ciw6tp")
      end

      it "returns the offsite URL with the EBSCO eResources URL" do
        expect(url).to eq "/catalog/000000/offsite?url=https%3A%2F%2Fresearch.ebsco.com%2Fc%2Fciw6tp"
      end
    end

    context "when user is logged in without EBSCO_ERESOURCES_URL configured" do
      let(:user) { create(:user) }

      before do
        allow(helper).to receive(:current_user).and_return(user)
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("EBSCO_ERESOURCES_URL").and_return(nil)
      end

      it "returns the guest URL as fallback" do
        expect(url).to eq "https://www.nla.gov.au/eresources"
      end
    end
  end
end
