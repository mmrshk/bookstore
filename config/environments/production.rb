Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier

  config.serve_static_assets = true
  config.assets.compile = true
  config.assets.initialize_on_precompile = false

  config.active_storage.service = :google

  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.force_ssl = true

  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = { host: 'radiant-plains-48256.herokuapp.com', :protocol => 'https'  }
  config.action_mailer.delivery_method=:smtp
  config.action_mailer.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    enable_starttls_auto: true,
    port: 587,
    domain: Rails.application.credentials.MAIL_HOST,
    authentication: :plain,
    user_name: 'emma.yeroshek@gmail.com',
    password: 'pronatashu',
    authentication: 'plain'
  }
end
