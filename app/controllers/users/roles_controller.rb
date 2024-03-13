class Users::RolesController < ApplicationController
  before_action :set_user
  before_action :set_role, only: %i[destroy]
  before_action { authorize(:role) }

  def index
    @roles = @user.roles
    
    @roles = @roles.page(page).per(page_size)
  end

  def new
    @role = @user.roles.build
  end

  def create
    @role = Role.where(role_params).first_or_create
    # resource = role_params[:resource_type].constantize if class_exists?(role_params[:resource_type])

    respond_to do |format|
      if @role.save
        @user.roles << @role unless @user.roles.include?(@role)
        format.html { redirect_to [@user, :roles], notice: "Role was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to [@user, :roles], notice: "Role was successfully destroyed." }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.fetch(:role, {}).permit(:resource_type, :name)
  end

  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
end