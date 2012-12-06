class Admin::UsersController < ApplicationController
  before_filter :allow_staff_only
  
  def index
    @users = User.all
  end
  
  private
  
  def allow_staff_only
    redirect_to authentications_path unless current_user.staff?
  end
end