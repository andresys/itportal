class DirectoriesController < ApplicationController
  def redirect
    if item = directory_items.first
      redirect_to [:directories, item.to_sym]
    else
      redirect_to root_path
    end
  end
end