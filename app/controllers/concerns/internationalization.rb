module Internationalization
  extend ActiveSupport::Concern

  included do
    # around_action :switch_locale
    before_action :switch_locale

    private

    # def switch_locale(&action)
    #   locale = locale_from_url || locale_from_headers || I18n.default_locale
    #   response.set_header "Content-Language", locale
    #   I18n.with_locale locale, &action
    # end

    def switch_locale
      locale = locale_from_url || (Setting.autodetect_locale && locale_from_headers) || Setting.default_locale
      # locale = locale_from_url || locale_from_headers || I18n.default_locale
      response.set_header "Content-Language", locale
      I18n.locale = locale
    end
    
    def locale_from_url
      locale = params[:locale]
      I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
    end
    
    # Adapted from https://github.com/rack/rack-contrib/blob/main/lib/rack/contrib/locale.rb
    def locale_from_headers
      header = request.env["HTTP_ACCEPT_LANGUAGE"]
      
      return if header.nil?
    
      locales = header.gsub(/\s+/, '').split(",").map do |language_tag|
        locale, quality = language_tag.split(/;q=/i)
        quality = quality ? quality.to_f : 1.0
        [locale, quality]
      end.reject do |(locale, quality)|
        locale == '*' || quality == 0
      end.sort_by do |(_, quality)|
        quality
      end.map(&:first)
    
      return if locales.empty?
    
      if I18n.enforce_available_locales
        locale = locales.reverse.find { |locale| I18n.available_locales.any? { |al| match?(al, locale) } }
        if locale
          I18n.available_locales.find { |al| match?(al, locale) }
        end
      else
        locales.last
      end
    end
    
    def match?(s1, s2)
      s1.to_s.casecmp(s2.to_s) == 0
    end
    
    def default_url_options
      { locale: [locale_from_headers, I18n.default_locale].include?(I18n.locale) ? locale_from_url : I18n.locale }
    end
  end
end