# frozen_string_literal: true

class ServiceTokenError < StandardError; end

class HoldingsRequestError < StandardError; end

class ItemRequestError < StandardError; end

class RequestDetailsError < StandardError; end

class UserDetailsError < StandardError; end

class CatalogueServicesClient
  MAX_TOKEN_RETRIES = 3

  def get_holdings(instance_id:)
    conn = setup_connection

    res = conn.get("/catalogue-services/folio/instance/#{instance_id}")
    if res.status == 200
      if res.body.present?
        res.body["holdingsRecords"]
      end
    else
      Rails.logger.error "Failed to retrieve holdings for #{instance_id}"
      raise HoldingsRequestError.new("Failed to retrieve holdings for #{instance_id}")
    end
  rescue => e
    Rails.logger.error "get_holdings - Failed to connect catalogue-service: #{e.message}"
    raise HoldingsRequestError.new("Failed to retrieve holdings for #{instance_id}")
  end

  def get_holding(instance_id:, holdings_id:, item_id:)
    all_holdings = get_holdings(instance_id: instance_id)

    # find holdings record
    holding = all_holdings.find { |h| h["id"] == holdings_id }

    # find item record
    item = holding["itemRecords"].find { |i| i["id"] == item_id }

    [holding, item]
  end

  def get_requestable(instance_id:, holdings_id:, item_id:)
    all_holdings = get_holdings(instance_id: instance_id)

    # find holdings record
    holding = all_holdings.find { |h| h["id"] == holdings_id }

    # find item record
    item = holding["itemRecords"].find { |i| i["id"] == item_id }

    item["requestable"] ? item["displayStatus"] : "Not for loan"
  end

  def get_item_ids(instance_id:)
    all_holdings = get_holdings(instance_id: instance_id)

    item_id = all_holdings.first["itemRecords"].first["holdingsRecordId"] if all_holdings.first["itemRecords"].any?

    holding_id = all_holdings.first["itemRecords"].first["id"] if all_holdings.first["itemRecords"].any?

    [item_id, holding_id]
  end

  def get_access_conditions(instance_id:, holdings_id:)
    all_holdings = get_holdings(instance_id: instance_id)

    # find holdings record
    holding = all_holdings.find { |h| h["id"] == holdings_id }

    # find item record
    item = holding["notes"].find { |i| i["holdingsNoteType"] == "Restriction" }

    item ? item["note"] : nil
  end

  def related_docs(pid:)
    conn = setup_connection

    res = conn.get("/catalogue-services/ead/relateddocs/#{pid}")
    if res.status == 200
      if res.body.present? && res.body["docs"].present?
        res.body["docs"].map do |attrs|
          attrs[:pid] = pid # insert the pid since we need it to construct the download URL
          RelatedDocument.new(attrs)
        end
      end
    else
      Rails.logger.error "Failed to retrieve related documents for #{pid}"
    end
  rescue => e
    Rails.logger.error "related_docs - Failed to connect catalogue-service: #{e.message}"
  end

  private

  def setup_connection
    Faraday.new(url: ENV["CATALOGUE_SERVICES_API_BASE_URL"]) do |f|
      f.response :json
    end
  end
end
