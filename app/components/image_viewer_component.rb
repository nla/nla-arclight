# frozen_string_literal: true

class ImageViewerComponent < ViewComponent::Base
  attr_reader :images

  def initialize(images)
    @images = images
  end

  def render?
    @images.any?
  end
end
