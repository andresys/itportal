class DirectoriesController < ApplicationController
  before_action :set_tabs

  def set_tabs
    @tabs = [:organizations, :employees, :mols, :locations]
  end
end