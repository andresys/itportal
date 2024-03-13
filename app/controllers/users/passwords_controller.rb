class Users::PasswordsController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action { authorize(@user || User) }

  def edit
  end

  def update
    respond_to do |format|
      @user.assign_attributes(user_params)
      if @user.save
        bypass_sign_in @user
        format.html { redirect_to [@user], notice: "Password was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.fetch(:user, {}).permit(:password, :password_confirmation)
  end
end