class ApplicationController < ActionController::Base
  include ErrorHandling
  include Internationalization
  include BackUrl

  helper_method :turbo_frame_request?
  
  layout :set_layout
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_id, :terms_of_service])
  end

  private

  def set_layout
    return false if request.xhr?

    return 'application' if controller_name == 'registrations' && ['edit', 'update'].include?(action_name)
  end
end
