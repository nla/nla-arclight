class IiifService
  def self.image(obj_id, region: "full", size: "full", rotation: 0, quality: "default", format: "jpg")
    conn = setup_connection

    url = "/dl-repo/iiif/#{obj_id}"
    url += "/#{region}" if region.present?
    url += "/#{size}" if size.present?
    url += "/#{rotation}" if rotation.present?
    url += "/#{quality}" if quality.present?
    url += ".#{format}" if format.present?

    streamed = []

    # e.g. http://localhost:3000/iiif/nla.obj-123/full/full/0/default.jpg
    conn.get(url) do |req|
      req.options.on_data = Proc.new do |chunk, overall_received_bytes, env|
        if env.status == 200
          Rails.logger.info "Received #{overall_received_bytes} bytes"
          streamed << chunk
        else
          # If the streaming of the image from the IIIF server fails, we should log the error and return nil
          # instead of a broken image.
          Rails.logger.error "Failed to retrieve IIIF image for #{obj_id}"
          return nil
        end
      end
    end

    streamed.join
  rescue => e
    Rails.logger.error "Failed to connect catalogue services: #{e.message}"
  end

  private_class_method

  def self.setup_connection
    # Timeout quickly, since there could be a very large number of images to fetch
    # from the IIIF server.
    Faraday.new(url: ENV["DL_REPO_BASE_URL"], request: {timeout: 10}) do |f|
      f.headers["Accept"] = "image/jpeg"
      f.headers["Content-Type"] = "image/jpeg"
    end
  end
end
