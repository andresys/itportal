class PreferencesController < ApplicationController
  before_action { authorize(current_user) }

  def edit
  end

  def update
    redirect_to [:profile], notice: "Preferences was successfully updated."
  end
end