class Mentor::FeedbacksController < Mentor::MentorController
  def contact
    @proposal = Proposal.mentors_can_read.find(params[:id])
    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid?
      FeedbacksMailer.contact(
        @proposal.talk_title,
        talk_url(@proposal),
        @proposal.talk.user,
        current_user,
        @feedback
      ).deliver_now
      redirect_to talk_path(@proposal.talk), :flash => {:notice => "Feedback sent" }
   else
      redirect_to talk_path(@proposal.talk), :flash => {:error => "Please give us some text :)." }
   end
  end
end
