class Mentor::MentorController < ApplicationController
  before_filter :allow_mentors_only

  def allow_mentors_only
    redirect_to root_path unless current_user.mentor?
  end
end
