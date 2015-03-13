source 'https://rubygems.org'

# We want to use 2.2 only on staging for now and the `ruby' command
# only supports specific versions down to the patch level.
if %w(2.1.5 2.2.0).include? RUBY_VERSION
  ruby RUBY_VERSION
end

gem 'dotenv-rails', groups: [:development, :test]

gem 'rails', '4.2.0'

gem 'devise', '~> 3.4.1'
gem 'simple_form', '~> 3.1.0'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'pg'
gem 'immigrant'

gem 'redcarpet'
gem 'settingslogic'
gem 'thin'

gem 'sass-rails',       '~> 5.0.0'
gem 'foundation-rails', '~> 5.4.0'
gem 'coffee-rails',     '~> 4.1.0'
gem 'uglifier',         '>= 1.0.3'
gem 'font-awesome-sass'
gem 'bourbon'

gem 'jquery-rails',     '~> 3.1.0'

gem 'rack-robotz',      '~> 0.0.3'
gem 'localeapp'
gem 'unicorn'

group :development do
  gem 'foreman'
  gem 'rails_layout'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'simplecov',  require: false
end

group :production, :staging do
  gem 'exception_notification', '~> 4.0.1'
  gem 'rails_12factor'
  gem 'shelly-dependencies'
  gem 'dotenv-deployment'
end
