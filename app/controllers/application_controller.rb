class ApplicationController < ActionController::Base
  include ErrorHandling

  layout proc { false if request.xhr? }
  before_action :save_back_url, :only => :index
  before_action :set_back_url

  private

  def save_back_url
    session[:back_url] = request.url
  end

  def set_back_url
    @back_url = session[:back_url] || url_for(action: 'index')
  end
end
