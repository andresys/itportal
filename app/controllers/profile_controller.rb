class ProfileController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action { authorize(:profile) }

  def show
  end

  def edit
  end

  private

  def set_user
    @user = current_user
  end
end