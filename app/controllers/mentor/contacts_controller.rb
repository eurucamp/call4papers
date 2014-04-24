class Mentor::ContactsController < Mentor::MentorController
  def contact
    @paper = Paper.mentors_can_read.find(params[:id])
  end
end
