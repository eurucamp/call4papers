require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = ENV.fetch('LOCALE_API_KEY', 'no_locale_key')
  config.polling_environments = []
  config.reloading_environments = []
  config.sending_environments = []
end
