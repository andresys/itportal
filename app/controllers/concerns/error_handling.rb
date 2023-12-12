module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :notfound if Rails.env == "production"

    private

    def notfound(exception)
      logger.warn exception
      render file: "public/404.#{I18n.locale || 'en'}.html", status: :not_found, layout: false
    end
  end
end