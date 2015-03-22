class Mentor::TalksController < Mentor::MentorController
  def index
    @talks = Talk.for_open_call.not_from(current_user).mentors_can_read.order('created_at DESC')
  end
end
