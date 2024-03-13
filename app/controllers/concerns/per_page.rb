module PerPage
  extend ActiveSupport::Concern
  
  included do
    private
    
    def page_size
      params[:per] || Setting.default_per_page
    end

    def page
      params[:page] || 0
    end
  end
end