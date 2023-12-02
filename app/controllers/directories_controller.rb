class DirectoriesController < ApplicationController
  before_action :set_tabs

  def set_tabs
    @tabs = [:organizations, :departments, :titles, :employees, :mols, :locations]
  end
end