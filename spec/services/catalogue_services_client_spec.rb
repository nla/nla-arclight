# frozen_string_literal: true

require "rails_helper"

RSpec.describe CatalogueServicesClient do
  subject(:service) { described_class.new }

  describe "#get_holdings" do
    before do
      cat_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")
      WebMock.stub_request(:get, /catservices.test\/catalogue-services\/folio\/instance\/08aed703-3648-54d0-80ef-fddb3c635731/)
        .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
    end

    it "returns holdings records" do
      expect(service.get_holdings(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731").size).to eq 5
    end

    context "when unable to request holdings" do
      it "raises a HoldingsRequestError" do
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/folio\/instance\/08aed703-3648-54d0-80ef-fddb3c635731/)
          .to_return(status: 401, body: "", headers: {"Content-Type" => "application/json"})

        expect { service.get_holdings(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731") }.to raise_error(HoldingsRequestError)
      end
    end
  end

  describe "#get_requestable" do
    before do
      cat_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")
      WebMock.stub_request(:get, /catservices.test\/catalogue-services\/folio\/instance\/08aed703-3648-54d0-80ef-fddb3c635731/)
        .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
    end

    it "returns the record's item id and holding id" do
      expect(service.get_item_ids(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731")).to eq %w[d6c97d9e-dfe6-5faa-9f0b-020b2bddbf8c 7460acfb-72b9-5dba-9089-603921fb47c7]
    end

    it "returns the record's requestable status" do
      expect(service.get_requestable(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731", holdings_id: "d6c97d9e-dfe6-5faa-9f0b-020b2bddbf8c", item_id: "7460acfb-72b9-5dba-9089-603921fb47c7")).to eq "Available"
    end
  end

  describe "#get_notes" do
    before do
      cat_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")
      WebMock.stub_request(:get, /catservices.test\/catalogue-services\/folio\/instance\/08aed703-3648-54d0-80ef-fddb3c635731/)
        .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
    end

    it "returns the record's item id and holding id" do
      expect(service.get_item_ids(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731")).to eq %w[d6c97d9e-dfe6-5faa-9f0b-020b2bddbf8c 7460acfb-72b9-5dba-9089-603921fb47c7]
    end

    it "returns the record's access condition notes or nil" do
      expect(service.get_notes(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731", holdings_id: "d6c97d9e-dfe6-5faa-9f0b-020b2bddbf8c", item_id: "7460acfb-72b9-5dba-9089-603921fb47c7")).to be_nil
    end
  end
end
