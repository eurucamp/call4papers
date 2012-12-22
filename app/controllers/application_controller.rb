class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  before_filter :load_counters

  def authenticate
    redirect_to authentications_path unless user_signed_in?
  end

  def load_counters
    @paper_count = Paper.count
    @user_count  = User.contributor.count
  end
end
