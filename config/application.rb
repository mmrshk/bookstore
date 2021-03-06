require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.action_controller.include_all_helpers = false
  end
end
