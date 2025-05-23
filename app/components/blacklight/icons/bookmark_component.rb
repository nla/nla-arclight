# frozen_string_literal: true

module Blacklight
  module Icons
    # The bookmark icon
    class BookmarkComponent < Blacklight::Icons::IconComponent
      self.svg = <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 384 512" role="img"><title>Bookmark</title><path d="M0 512V48C0 21.49 21.49 0 48 0h288c26.51 0 48 21.49 48 48v464L192 400 0 512z"/></svg>
      SVG
    end
  end
end
