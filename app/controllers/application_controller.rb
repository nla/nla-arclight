class ApplicationController < ActionController::Base
  # defines #new_session_path(scope) to allow correct redirection when only using OmniAuth
  include AuthSessionConcern

  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include Blacklight::LocalePicker::Concern
  layout :determine_layout if respond_to? :layout

  before_action :store_user_location!, if: :storable_location?

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  # :nocov:
  def storable_location?
    request.get? &&
      is_navigational_format? &&
      (is_a_storable_controller_action? && !devise_controller?) &&
      !request.xhr?
  end

  # Some parts of the application are not suitable for storing the location
  def is_a_storable_controller_action?
    !is_a?(Users::SessionsController) && # ignore login requests
      !is_a?(Users::OmniauthCallbacksController) # ignore login requests to Keycloak
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
  # :nocov:
end
