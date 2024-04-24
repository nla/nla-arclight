# frozen_string_literal: true

class ShowPresenter < Arclight::ShowPresenter
  def heading
    "Guide to the " + document.normalized_title
  end
end
