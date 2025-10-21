module ApplicationHelper
  include Blacklight::LocalePicker::LocaleHelper

  def additional_locale_routing_scopes
    [blacklight, arclight_engine]
  end

  def show_analytics?
    response.status != 404 || !routing_error?
  end

  private

  def routing_error?
    params[:controller] == "application" && params[:action] == "routing_error"
  end
end
