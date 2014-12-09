source 'https://rubygems.org'

ruby '2.1.5'

gem 'dotenv-rails', groups: [:development, :test]

gem 'rails', '4.0.3'

gem 'devise', '~> 3.2.2'
gem 'simple_form', '~> 3.0.1'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'pg'
gem 'foreigner'
gem 'immigrant'

gem 'redcarpet'
gem 'settingslogic'
gem 'thin'

gem 'sass-rails',       '~> 4.0.0'
gem 'foundation-rails'
gem 'coffee-rails',     '~> 4.0.0'
gem 'uglifier',         '>= 1.0.3'
gem 'font-awesome-sass'
gem 'bourbon'

gem 'jquery-rails',     '~> 3.1.0'

gem 'rack-robotz',      '~> 0.0.3'
gem 'localeapp'

group :development do
  gem 'foreman'
  gem 'rails_layout'
end

group :test do
  gem 'turn',       require: false
  gem 'simplecov',  require: false
end

group :production, :staging do
  gem 'exception_notification', '~> 4.0.1'
  gem 'rails_12factor'
  gem 'shelly-dependencies'
  gem 'dotenv-deployment'
end
