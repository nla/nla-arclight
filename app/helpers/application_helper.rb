module ApplicationHelper
  include Blacklight::LocalePicker::LocaleHelper

  def additional_locale_routing_scopes
    [blacklight, arclight_engine]
  end

  def eresources_link_url
    ebsco_eresources_url = ENV["EBSCO_ERESOURCES_URL"]
    if current_user.present? && ebsco_eresources_url.present?
      ebsco_eresources_url
    else
      ENV.fetch("ERESOURCES_GUEST_URL", "https://www.nla.gov.au/eresources")
    end
  end

  def show_analytics?
    response.status != 404 || !routing_error?
  end

  private

  def routing_error?
    params[:controller] == "application" && params[:action] == "routing_error"
  end
end
