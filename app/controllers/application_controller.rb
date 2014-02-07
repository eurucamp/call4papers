class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  before_filter :load_counters

  rescue_from(ActionController::ParameterMissing) do |exception|
    render nothing: true, status: 400
  end

  def authenticate
    redirect_to authentications_path unless user_signed_in?
  end

  def load_counters
    @paper_counts = Paper.for_open_call.group(:call).count
    @user_count   = User.contributor.count
  end
end
