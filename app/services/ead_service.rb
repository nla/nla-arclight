# frozen_string_literal: true

class EadService
  def self.finding_aid(obj_id)
    conn = setup_connection

    res = conn.get("/catalogue-services/ead/#{obj_id}")
    if res.status == 200
      res.body.presence
    else
      Rails.logger.error "Failed to retrieve finding aid for #{obj_id}"
      nil
    end
  rescue => e
    Rails.logger.error "Failed to connect to catalogue-service: #{e.message}"
    nil
  end

  def self.setup_connection
    Faraday.new(url: ENV["CATALOGUE_SERVICES_API_BASE_URL"]) do |faraday|
      faraday.response :json
    end
  end
end
