class SettingsController < ApplicationController
  before_action { authorize(:setting) }

  def edit
  end

  def general
    update_settings(general_params)

    redirect_to [:settings], notice: "General setting was successfully updated."
  end

  def notification
    update_settings(notification_params)

    redirect_to [:settings], notice: "Notification setting was successfully updated."
  end

  private

  def update_settings(setting_params)
    @errors = ActiveModel::Errors.new(self)
    setting_params.keys.each do |key|
      next if setting_params[key].nil?

      setting = Setting.new(var: key)
      setting.value = setting_params[key].strip
      unless setting.valid?
        @errors.merge!(setting.errors)
      end
    end

    if @errors.any?
      render :edit
    end

    setting_params.keys.each do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end
  end

  def general_params
    params.require(:setting).permit(:default_locale, :autodetect_locale, :default_per_page)
  end
end