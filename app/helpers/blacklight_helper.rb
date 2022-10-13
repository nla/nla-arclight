module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def application_name
    t("blacklight.application_name")
  end

  def render_page_title
    prefix = case ENV["RAILS_ENV"]
    when "development" then "[DEV] "
    when "staging" then "[TEST] "
    else ""
    end
    # rubocop:disable Rails/HelperInstanceVariable
    prefix + ((content_for(:page_title) if content_for?(:page_title)) || @page_title || application_name)
    # rubocop:enable Rails/HelperInstanceVariable
  end
end
