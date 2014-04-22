class Mentor::PapersController < Mentor::MentorController
  def index
    @papers = Paper.mentors_can_read.order('created_at DESC')
  end
end
