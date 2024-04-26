# frozen_string_literal: true

class ShowPresenter < Arclight::ShowPresenter
  def heading
    I18n.t('collection_prefix') + document.normalized_title
  end
end
