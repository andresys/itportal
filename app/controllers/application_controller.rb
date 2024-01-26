class ApplicationController < ActionController::Base
  include ErrorHandling
  include Internationalization

  helper_method :turbo_frame_request?
  
  layout proc { false if request.xhr? }
  before_action :save_back_url, :only => :index
  before_action :set_back_url, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_id, :terms_of_service])
  end

private
  def save_back_url
    session[:back_url] = request.url
  end

  def set_back_url
    @back_url = session[:back_url] || url_for(action: 'index')
  end
end
