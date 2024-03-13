class Users::ApprovedsController < ApplicationController
  before_action :set_user
  before_action { authorize(:approved) }

  def create
    respond_to do |format|
      if @user.update(approved: true)
        format.html { redirect_to [@user], notice: "User was successfully approved." }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.update(approved: false)
        format.html { redirect_to [@user], notice: "User is no longer approved." }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end