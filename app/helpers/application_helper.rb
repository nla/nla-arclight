require "uri"

module ApplicationHelper
  include Blacklight::LocalePicker::LocaleHelper

  # :nocov:
  def additional_locale_routing_scopes
    [blacklight, arclight_engine]
  end
  # :nocov:

  def nla_catalogue_url
    "#{request.protocol}#{request.host}"
  end
end
