class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action { authorize(@user || User) }

  def index
    # @users = ActiveDirectory::User.find(:all)
    user = User.arel_table
    matches_string_user =  ->(p){ user[p].lower.matches("%#{params[:q]&.downcase}%") }
    
    employee = Employee.arel_table
    matches_string_employee =  ->(p){ employee[p].lower.matches("%#{params[:q]&.downcase}%") }

    @organization = Organization.find_by_id(params[:organization] ||= nil)

    @query = request.query_parameters
    @approved = ['yes', 'no'].include?(params[:approved]) && params[:approved] || 'yes'

    query_parameters = {} #{delete_mark: false}

    if @approved
      query_parameters.merge!(approved: {'yes' => true, 'no' => false}[@approved])
    end

    if @organization || params[:organization] == '0'
      query_parameters.merge!(organization: {id: @organization})
    end

    @users = User.left_joins(:employee)
      .where(query_parameters)
      .where(matches_string_user.(:email).or(matches_string_employee.(:name)))
      .group(:id)
    
    # @users = @users.having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    # @users = @users.having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s

    @users = @users.page(page).per(page_size)
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.approved = true
    @user.skip_confirmation_notification!
    @user.confirmed_at = DateTime.now

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
      params.fetch(:user, {}).permit(:employee_id, :email, :password, :password_confirmation, :terms_of_service, :approved)
    end
end
