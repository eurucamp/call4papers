class Mentor::PapersController < Mentor::MentorController
  def index
    @papers = Paper.order('created_at DESC')
  end
end
