# frozen_string_literal: true

class IiifService
  def self.image_info(obj_id)
    conn = setup_connection
    res = conn.get("/dl-repo/ImageController/iiif/#{obj_id}/info")
    if res.status == 200
      res.body
    else
      Rails.logger.error "Failed to retrieve IIIF image info for #{obj_id}"
      nil
    end
  rescue => e
    Rails.logger.error "Failed to connect to catalogue services: #{e.message}"
  end

  def self.image(id, region: "full", size: "full", rotation: 0, quality: "default", format: "jpg")
    # Timeout quickly, since there could be a very large number of images to fetch
    # from the IIIF server.
    conn = Faraday.new(url: ENV["DL_REPO_BASE_URL"]) do |f|
      f.headers["Accept"] = "image/jpeg"
      f.headers["Content-Type"] = "image/jpeg"
    end

    url = "/dl-repo/iiif/#{id}"
    url += "/#{region}" if region.present?
    url += "/#{size}" if size.present?
    url += "/#{rotation}" if rotation.present?
    url += "/#{quality}" if quality.present?
    url += ".#{format}" if format.present?

    streamed = []

    # e.g. http://localhost:3000/iiif/nla.obj-123/full/full/0/default.jpg
    conn.get(url) do |req|
      req.options.on_data = proc do |chunk, overall_received_bytes, env|
        if env.status == 200
          Rails.logger.info "Received #{overall_received_bytes} bytes"
          streamed << chunk
        else
          # If the streaming of the image from the IIIF server fails, we should log the error and return nil
          # instead of a broken image.
          Rails.logger.error "Failed to retrieve IIIF image for #{id}"
          streamed = []
        end
      end
    end

    unless streamed.empty?
      streamed.join
    end
  rescue => e
    Rails.logger.error "Failed to connect to catalogue services: #{e.message}"
  end

  private_class_method

  def self.setup_connection
    Faraday.new(url: ENV["DL_REPO_BASE_URL"]) do |f|
      f.response :json
    end
  end
end
