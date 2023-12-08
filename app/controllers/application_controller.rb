class ApplicationController < ActionController::Base
  include ErrorHandling

  layout proc { false if request.xhr? }
  before_action :set_back_url, :only => :index

  private

  def set_back_url
    session[:back_url] = request.url
  end
end
