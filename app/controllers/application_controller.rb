class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include Internationalization
  include BackUrl
  include ErrorHandling
  include Authorization
  include PerPage

  layout :set_layout

  helper_method :turbo_frame_request?
  helper_method :policy
  helper_method :accounting_items, :directory_items, :user_action_items

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: -> { %w[static_pages].include? controller_name }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_id, :terms_of_service])
  end

  private

  def set_layout
    return false if request.xhr?

    return 'application' if controller_name == 'registrations' && %w[edit update].include?(action_name)
  end

  def accounting_items
    items = []
    items << 'assets' if policy(:asset).index?
    items << 'materials' if policy(:material).index?
    items << 'notes' if policy(:note).index?
    # items << 'prints' if policy(:print).index?
    items
  end

  def directory_items
    items = []
    items << 'organizations' if policy(:organization).index?
    items << 'employees' if policy(:employee).index?
    items << 'mols' if policy(:mol).index?
    items << 'locations' if policy(:location).index?
    items << 'asset_types' if policy(:asset_type).index?
    items
  end

  def user_action_items user = nil
    items = []
    items << 'approveds' if policy(user || User).create_approved? || policy(user || User).destroy_approved?
    items << 'users' if policy(user || User).destroy?
    items
  end
end
