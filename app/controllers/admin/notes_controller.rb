class Admin::NotesController < Admin::AdminController
  def create
    proposal = Proposal.find(params[:id])
    note = current_user.notes.new(proposal_id: proposal.id, :content => params[:note][:content])
    note.save!
    redirect_to admin_proposal_path(proposal)
  end

  def update
    note = current_user.notes.where(proposal_id: params[:id]).first
    note.content = params[:note][:content]
    note.save!
    redirect_to admin_proposal_path(params[:id])
  end
end
