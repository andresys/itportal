# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  # Define your fields
  # field :host, type: :string, default: "http://localhost:3000"
  # field :omniauth_google_client_id, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_ID"] || ""), type: :string, readonly: true
  # field :omniauth_google_client_secret, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_SECRET"] || ""), type: :string, readonly: true
  # field :admin_emails, default: "admin@rubyonrails.org", type: :array
  scope :general do
    field :default_locale, default: "en", type: :string
    field :autodetect_locale, default: true, type: :boolean
    field :default_per_page, default: 20, type: :integer
  end
  
  scope :notification do
    field :confirmable_enable, default: "0", type: :boolean
    field :mailer_sender, default: "itportal@adm.tver.ru", type: :string
  end
end
