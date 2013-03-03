ENV["RAILS_ENV"] = "test"
require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::TestHelpers
end

OmniAuth.config.test_mode = true
#OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
#  provider: 'twitter',
#  uid:      'ecc22050'
#})
OmniAuth.config.add_mock(:twitter, {
  uid:      'e644e6e0',
  nickname: 'fooman'
})
