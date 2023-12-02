class Directories::DepartmentsController < DirectoriesController
  def index
    @departments = params[:parent] && (!params[:parent].empty? && Department.where("parent_id = ?", params[:parent]) || Department.roots) || Department.all
  end
end 