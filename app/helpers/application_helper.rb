require "uri"

module ApplicationHelper
  include Blacklight::LocalePicker::LocaleHelper

  # :nocov:
  def additional_locale_routing_scopes
    [blacklight, arclight_engine]
  end
  # :nocov:
end
