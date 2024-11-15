require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ArtCollectorWeb
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join('lib')
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.assets.enabled = true
    # config.assets.paths << Rails.root.join('/app/assets/fonts')
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.serve_static_assets = true

    config.active_job.queue_adapter = :delayed_job
    end
end
