class EadService
  def self.findingaid(obj_id)
    conn = setup_connection

    res = conn.get("/catalogue-services/ead/#{obj_id}")
    if res.status == 200
      res.body.presence
    else
      Rails.logger.error "Failed to retrieve finding aid for #{obj_id}"
    end
  rescue => e
    Rails.logger.error "Failed to connect catalogue-service: #{e.message}"
  end

  private_class_method

  def self.setup_connection
    Faraday.new(url: ENV["CATALOGUE_SERVICES_API_BASE_URL"]) do |f|
      f.response :json
    end
  end
end
