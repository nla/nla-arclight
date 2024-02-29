class IiifController < ApplicationController
  before_action :image_params

  def image
    data = IiifService.image(image_params[:id])
    if data.present?
      send_data data, type: "image/jpeg", disposition: "inline"
    else
      render "errors/not_found", status: :not_found
    end
  end

  def image_info
    data = IiifService.image_info(image_params[:id])
    if data.present?
      render json: data
    else
      render "errors/not_found", status: :not_found
    end
  end

  def manifest
    finding_aid = EadService.finding_aid(manifest_params)

    # Use metadata about the children from the finding aid to build the manifest.
    if finding_aid.present?
      manifest_id = iiif_manifest_url(finding_aid["pid"])
      manifest = ManifestService.init_manifest(manifest_id: manifest_id, label: finding_aid["title"])

      if finding_aid["children"]["manuscript"].any?
        # Add a sequence to the manifest.
        sequence_id = "#{root_url}/iiif/#{finding_aid["pid"]}/sequence/normal"
        sequence = ManifestService.sequence(sequence_id: sequence_id)
        manifest.sequences << sequence

        # Add a canvas to the sequence for each child.
        finding_aid["children"]["manuscript"].each do |child|
          # Only include items that are unrestricted and not sensitive.
          if (child["digitalStatus"].parameterize == "captured" || child["digitalStatus"].parameterize == "partially captured") &&
              child["accessConditions"].parameterize == "unrestricted" &&
              child["sensitiveMaterial"].parameterize == "no"

            artefact = IiifService.image_info(child["pid"])
            if artefact.present?
              canvas_id = "#{root_url}/iiif/#{finding_aid["pid"]}/canvas/#{SecureRandom.uuid}"
              canvas = ManifestService.canvas(canvas_id: canvas_id, width: artefact["width"], height: artefact["height"], label: child["title"])

              service = ManifestService.service(service_id: iiif_image_info_url(id: child["pid"]), width: artefact["width"], height: artefact["height"], tiles: artefact["tiles"])

              image = ManifestService.image(image_id: iiif_image_url(id: child["pid"]), service: service, canvas: canvas)
              images = IIIF::Presentation::Resource.new("@type" => "oa:Annotation", "motivation" => "sc:painting", "@id" => "#{canvas['@id']}/images", "resource" => image)
              canvas.images << images

              thumbnail = ManifestService.image(image_id: iiif_image_url(id: child["pid"], size: "256, 256"), service: service)
              canvas["thumbnail"] = thumbnail

              # set the first image as the thumbnail for the manifest
              if manifest["thumbnail"].nil?
                manifest["thumbnail"] = thumbnail
              end

              manifest.sequences.first.canvases << canvas
            end
          end
        end
      end

      render json: manifest.to_json(pretty: true)
    else
      render "errors/not_found", status: :not_found
    end
  end

  private

  def image_params
    params.permit(:id, :size)
  end

  def manifest_params
    params.require(:id)
  end
end
