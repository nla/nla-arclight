require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load dotenv only in development or test environment
if %w[development test].include? ENV["RAILS_ENV"]
  require "dotenv/load"
end

module NlaArclight
  VERSION = "3.7.1"

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = "Canberra"

    config.assets.configure do |env|
      env.cache = ActiveSupport::Cache.lookup_store(:file_store, File.join(ENV.fetch("ARCLIGHT_TMP_PATH", "./tmp"), "asset/cache"))
    end

    config.assets.prefix = "/finding-aids/assets"

    # Don't generate system test files.
    config.generators.system_tests = nil

    Prometheus::Client.config.data_store = Prometheus::Client::DataStores::DirectFileStore.new(dir: File.join(ENV.fetch("ARCLIGHT_TMP_PATH", "./tmp"), "prometheus_direct_file_store"))

    config.version = VERSION
  end
end
