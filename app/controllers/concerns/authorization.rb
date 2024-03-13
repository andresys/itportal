module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    after_action :verify_authorized, unless: :bypass_auth

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    # rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:danger] = t 'global.flash.not_authorized'
      # url = @back_url == request.url ? request.referer : @back_url
      redirect_to(request.referer || root_path)
    end

    def bypass_auth
      devise_controller? || %w[static_pages dashboard prints accounting directories].include?(controller_name)
    end
  end
end