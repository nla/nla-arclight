# frozen_string_literal: true

require "rails_helper"

RSpec.describe CatalogueServicesClient do
  subject(:service) { described_class.new }

  # WebMock.stub_request(:get, "http://catservices.test/catalogue-services/folio/instance/6bf69425-293d-5e3f-a050-16124aca9a4e").
  #   with(
  #     headers: {
  #       'Accept'=>'*/*',
  #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #     }).
  #   to_return(status: 200, body: "", headers: {})

  describe "#get_holdings" do
    context "when unable to request holdings" do
      it "raises a ItemRequestError" do
        WebMock.stub_request(:get, "http://catservices.test/catalogue-services/folio/instance/08aed703-3648-54d0-80ef-fddb3c635731")
               .with(
                 headers: {
                   "Accept" => "*/*",
                   "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
                 }
               )
               .to_return(status: 401, body: "", headers: {})

        expect { service.get_holdings(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731") }.to raise_error(HoldingsRequestError)
      end
    end

    context "when requesting holdings records" do
      it "returns holdings records" do
        # ________________from file
        cat_response = IO.read("spec/files/catalogue_services/08aed703-3648-54d0-80ef-fddb3c635731.json")
        WebMock.stub_request(:get, "http://catservices.test/catalogue-services/folio/instance/08aed703-3648-54d0-80ef-fddb3c635731")
               .with(
                 headers: {
                   "Accept" => "*/*",
                   "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
                 }
               )
               .to_return(status: 200, body: cat_response, headers: {})

        # ________________empty stub
        # WebMock.stub_request(:get, "http://catservices.test/catalogue-services/folio/instance/08aed703-3648-54d0-80ef-fddb3c635731")
        #        .with(
        #          headers: {
        #            "Accept" => "*/*",
        #            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        #          }
        #        )
        #        .to_return(status: 200, body: "", headers: {})

        pp service.get_holdings(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731")
        expect(service.get_holdings(instance_id: "08aed703-3648-54d0-80ef-fddb3c635731").size).to eq 5
      end
    end
  end


  # describe "#get_holdings" do
  #   it "returns holdings records" do
  #     pp service.get_holdings(instance_id: "6bf69425-293d-5e3f-a050-16124aca9a4e")
  #     expect(service.get_holdings(instance_id: "6bf69425-293d-5e3f-a050-16124aca9a4e")).to eq 1
  #   end
  # end

  # describe "#get_item_ids" do
  #   it "returns item id and holding id" do
  #     expect(service.get_item_ids(instance_id: "6bf69425-293d-5e3f-a050-16124aca9a4e")).to eq %w[565c607a-4a21-5a9c-bc22-370947bb9a7c bed76196-e6ed-50d8-b658-ef64ce8ad90e]
  #   end
  # end
  #
  # describe "#get_requestable" do
  #   it "returns item's requestable status" do
  #     expect(service.get_requestable(instance_id: "6bf69425-293d-5e3f-a050-16124aca9a4e",
  #                                    holdings_id: "565c607a-4a21-5a9c-bc22-370947bb9a7c",
  #                                    item_id: "bed76196-e6ed-50d8-b658-ef64ce8ad90e")).to eq false
  #   end
  # end
end
