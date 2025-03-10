# frozen_string_literal: true

module Blacklight
  module Icons
    # The container icon
    class ContainerComponent < Blacklight::Icons::IconComponent
      # Used unmodified from https://fontawesome.com
      # CC BY 4.0 https://creativecommons.org/licenses/by/4.0/
      self.svg = <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" height="24" width="24" viewBox="0 0 512 512" role="img"><title>Container</title><path d="M464 128H272l-64-64H48C21.49 64 0 85.49 0 112v288c0 26.51 21.49 48 48 48h416c26.51 0 48-21.49 48-48V176c0-26.51-21.49-48-48-48z"/></svg>
      SVG
    end
  end
end
