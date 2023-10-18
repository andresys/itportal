class ApplicationController < ActionController::Base
  layout proc { false if request.xhr? }
end
