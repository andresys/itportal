class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    # @users = ActiveDirectory::User.find(:all)
    user = User.arel_table
    matches_string_user =  ->(p){ user[p].lower.matches("%#{params[:q]&.downcase}%") }
    
    employee = Employee.arel_table
    matches_string_employee =  ->(p){ employee[p].lower.matches("%#{params[:q]&.downcase}%") }

    @organization = Organization.find_by_id(params[:organization] ||= nil)

    @query = request.query_parameters

    query_parameters = {} #{delete_mark: false}

    if @organization || params[:organization] == '0'
      query_parameters.merge!(organization: {id: @organization})
    end

    page_size = params[:per] || 10
    page = params[:page] || 0

    @users = User.left_joins(:employee)
      .where(query_parameters)
      .where(matches_string_user.(:email))
      .where(matches_string_employee.(:name))
      .group(:id)
    
    # @users = @users.having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    # @users = @users.having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s

    @users = @users.page(page).per(page_size)
  end

  def new
    @user = User.new
  end

  def show
    render :edit
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @back_url, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @back_url, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to @back_url, notice: "User was successfully destroyed." }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.fetch(:user, {}).permit(:employee_id, :email, :password, :password_confirmation)
    end
end
