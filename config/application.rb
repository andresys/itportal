require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = "Europe/Moscow"
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :en

    config.active_job.queue_adapter = :sidekiq

    config.action_view.preload_links_header = false

    config.count_record_list = %w[10 15 20 25 30 40 50 75 100]
  end
end