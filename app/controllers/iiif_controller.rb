class IiifController < ApplicationController
  before_action :image_params

  def image
    data = IiifService.image(image_params)
    if data.present?
      send_data data, type: "image/jpeg", disposition: "inline"
    else
      render "errors/not_found", status: :not_found
    end
  end

  private

  def image_params
    params.require(:id)
  end
end
