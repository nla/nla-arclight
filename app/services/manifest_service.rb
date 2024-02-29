class ManifestService
  def self.init_manifest(manifest_id:, label:)
    # Create a seed to identify this manifest.
    # Also set the label to the title from the finding aid.
    seed = {
      "@id" => manifest_id,
      "label" => label
    }

    IIIF::Presentation::Manifest.new(seed)
  end

  def self.sequence(sequence_id:)
    sequence = IIIF::Presentation::Sequence.new
    sequence["@id"] = sequence_id
    sequence.label = "Current page order"
    sequence.viewing_direction = "left-to-right"
    sequence.viewing_hint = "paged"
    sequence
  end

  def self.service(service_id:, width:, height:, tiles:)
    service = IIIF::Presentation::Resource.new
    service["@id"] = service_id
    service["width"] = width
    service["height"] = height
    service["tiles"] = tiles
    service
  end

  def self.canvas(canvas_id:, width:, height:, label:)
    canvas = IIIF::Presentation::Canvas.new
    canvas["@id"] = canvas_id
    canvas["width"] = width
    canvas["height"] = height
    canvas["label"] = label
    canvas
  end

  def self.image(image_id:, service:, canvas: nil)
    image = IIIF::Presentation::ImageResource.new
    image["@id"] = image_id
    image.format = "image/jpeg"
    image.service = service
    if canvas.present?
      image["on"] = canvas["@id"]
    end
    image
  end
end
