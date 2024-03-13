class Users::EmailsController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action { authorize(@user || User) }

  def edit
  end

  def update
    respond_to do |format|
      @user.skip_confirmation_notification!
      if @user.update(user_params)
        @user.confirm
        format.html { redirect_to [@user], notice: "Email was successfully updated." }
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
    params.fetch(:user, {}).permit(:email)
  end
end