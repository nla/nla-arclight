# frozen_string_literal: true

class ImageController < ApplicationController
  def image
    data = IiifService.image(image_params[:id])
    if data.present?
      send_data data, type: "image/jpeg", disposition: "inline"
    else
      render "errors/not_found", status: :not_found
    end
  end

  private

  def image_params
    params.permit(:id)
  end
end
