CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     '',
    # google_storage_access_key_id:     Rails.application.credentials.GOOGLE_STORAGE_ACCESS_KEY_ID,
    # google_storage_secret_access_key: Rails.application.credentials.GOOGLE_STORAGE_SECRET_ACCESS_KEY
    google_storage_secret_access_key: ''
  }
  config.fog_directory = 'radiant-plains-48256'

  if Rails.env.production?
    config.storage = :fog
  else
    config.storage = :file
  end
end
