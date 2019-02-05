require 'rails_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist_custom do |app|
  driver_config = {
    debug: false,
    inspector: true,
    js_errors: true,
    timeout: 60,
    window_size: [1900, 1200],
    phantomjs_options: %w[--load-images=yes --ignore-ssl-errors=yes --ssl-protocol=any]
  }

  Capybara::Poltergeist::Driver.new(app, driver_config)
end

Capybara.default_driver = :poltergeist_custom

Capybara.configure do |config|
  config.default_driver = :poltergeist_custom
  config.javascript_driver = :poltergeist_custom
  config.default_max_wait_time = 2
  config.server_port = 54_321
  config.default_host = 'localhost:3000'
end
