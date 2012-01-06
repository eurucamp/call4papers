class ApplicationController < ActionController::Base
  protect_from_forgery

  attr_accessor :skip_secondary
  helper_method :skip_secondary
end
