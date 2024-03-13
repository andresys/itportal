class Directories::OrganizationsController < DirectoriesController
  before_action :set_organization, only: %i[edit update destroy]
  before_action { authorize(@organization || Organization) }

  def index
    organization = Organization.arel_table
    matches_string =  ->(p){ organization[p].lower.matches("%#{params[:q]&.downcase}%") }

    @query = request.query_parameters

    query_parameters = {}

    @organizations = Organization.left_joins(nil)
      .where.not(name: nil)
      .where(query_parameters)
      .where(matches_string.(:name))
      .group(:id)
    
    @organizations = @organizations.page(page).per(page_size)
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    @organization = Organization.new(organization_params)
    respond_to do |format|
      if @organization.save
        format.html { redirect_to @back_url, notice: "Organization was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @back_url, notice: "Organization was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to @back_url, notice: "Organization was successfully destroyed." }
    end
  end

private
  def organization_params
    params.fetch(:organization, {}).permit(:name)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end