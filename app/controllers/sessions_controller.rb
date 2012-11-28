class SessionsController < Devise::SessionsController
  skip_before_filter :authenticate
  layout 'welcome'
end
