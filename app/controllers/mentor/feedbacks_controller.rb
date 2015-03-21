class Mentor::FeedbacksController < Mentor::MentorController
  def contact
    @proposal = Proposal.mentors_can_read.find(params[:id])
    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid?
      FeedbacksMailer.contact(
        @proposal.talk_title,
        proposal_url(@proposal),
        @proposal.talk.user,
        current_user,
        @feedback
      ).deliver_now
      redirect_to proposal_path(@proposal), :flash => {:notice => "Feedback sent" }
   else
      redirect_to proposal_path(@proposal), :flash => {:error => "Please give us some text :)." }
   end
  end
end
