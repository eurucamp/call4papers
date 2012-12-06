class Admin::PapersController < ApplicationController
  before_filter :allow_staff_only

  def index
    @papers = Paper.all
  end

  private

  def allow_staff_only
    redirect_to root_path unless current_user.staff?
  end
end
