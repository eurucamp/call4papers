class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  attr_accessor :skip_secondary
  helper_method :skip_secondary
end
