module BackUrl
  extend ActiveSupport::Concern

  included do
    before_action :save_back_url, :only => :index
    before_action :set_back_url

    private

    def save_back_url
      session[:back_url] = request.url
    end
  
    def set_back_url
      @back_url = session[:back_url] || self.respond_to?(:index) && url_for(action: 'index') || root_path
    end

  end
end