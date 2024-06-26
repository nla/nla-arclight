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

  describe "#get_access_conditions" do
    before do
      cat_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")
      WebMock.stub_request(:get, /catservices.test\/catalogue-services\/folio\/instance\/08aed703-3648-54d0-80ef-fddb3c635731/)
        .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
    end

    it "returns the record's item id and holding id" do
      expect(service.get_item_ids(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731")).to eq %w[d6c97d9e-dfe6-5faa-9f0b-020b2bddbf8c 7460acfb-72b9-5dba-9089-603921fb47c7]
    end

    it "returns the record's access condition notes or nil" do
      expect(service.get_access_conditions(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731", holdings_id: "d6c97d9e-dfe6-5faa-9f0b-020b2bddbf8c")).to be_nil
    end
  end

  describe "#related_docs" do
    context "when there are related records" do
      before do
        cat_response = IO.read("spec/files/catalogue_services/related_docs.json")
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/ead\/relateddocs\/nla.obj-123/)
          .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
      end

      let(:related_docs) { service.related_docs(pid: "nla.obj-123") }

      it "returns the related records" do
        expect(related_docs).not_to be_nil
        expect(related_docs.size).to eq 4
        expect(related_docs.first["id"]).to eq "nla.obj-367760674"
        expect(related_docs.first["copyRole"]).to eq "fas"
        expect(related_docs.first["fileName"]).to eq "Finding aid supplementary"
        expect(related_docs.first["fileType"]).to eq "pdf"
        expect(related_docs.first["fileSize"]).to eq 124305
      end
    end

    context "when there are no related records" do
      before do
        cat_response = IO.read("spec/files/catalogue_services/no_related_docs.json")
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/ead\/relateddocs\/nla.obj-123/)
          .to_return(status: 200, body: cat_response, headers: {"Content-Type" => "application/json"})
      end

      it "returns an empty response" do
        expect(service.related_docs(pid: "nla.obj-123")).to be_nil
      end
    end

    context "when the service returns an error" do
      before do
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/ead\/relateddocs\/nla.obj-123/)
          .to_return(status: 500, body: "", headers: {"Content-Type" => "application/json"})
      end

      it "returns an empty response" do
        expect(service.related_docs(pid: "nla.obj-123")).to be_nil
      end
    end

    context "when failed to connect to catalogue-service" do
      before do
        WebMock.stub_request(:get, /catservices.test\/catalogue-services\/ead\/relateddocs\/nla.obj-123/)
          .to_raise(StandardError)
      end

      it "returns an empty response" do
        expect(service.related_docs(pid: "nla.obj-123")).to be_nil
      end
    end
  end
end
