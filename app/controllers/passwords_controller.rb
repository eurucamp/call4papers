class PasswordsController < Devise::PasswordsController
  skip_before_filter :authenticate
  layout 'welcome'
end
