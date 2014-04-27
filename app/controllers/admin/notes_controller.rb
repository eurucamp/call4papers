class Admin::NotesController < Admin::AdminController
  def create
    paper = Paper.find(params[:id])
    note = current_user.notes.new(paper_id: paper.id, :content => params[:note][:content])
    note.save!
    redirect_to paper_path(paper)
  end

  def update
    note = current_user.notes.where(paper_id: params[:id]).first
    note.content = params[:note][:content]
    note.save!
    redirect_to paper_path(params[:id])
  end
end
