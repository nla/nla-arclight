# frozen_string_literal: true

class ShowPresenter < Arclight::ShowPresenter
  def heading
    if document.collection?
      I18n.t("collection_prefix") + document.normalized_title
    else
      document.normalized_title
    end
  end
end
