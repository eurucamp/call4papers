class PapersController < ApplicationController
  skip_before_filter :authenticate, only: :show

  def index
    @papers = current_user.papers.order("created_at DESC")
  end

  def show
    @paper = Paper.find(params[:id])
    @user  = @paper.user
  end

  def new
    @paper = current_user.papers.new
  end

  def edit
    @paper = current_user.papers.editable.find(params[:id])
  end

  def create
    @paper = current_user.papers.new(paper_params)
    @paper.track = 'Test'

    if @paper.save
      notify_excited_organizers
      redirect_to @paper, notice: "Great job! You've successfully proposed a paper for JRubyConf EU."
    else
      render :new
    end
  end

  def update
    @paper = current_user.papers.editable.find(params[:id])

    if @paper.update_attributes(paper_params)
      redirect_to @paper, notice: "Well done! Your proposal has been updated."
    else
      render :edit
    end
  end

  def destroy
    @paper = current_user.papers.editable.find(params[:id])
    @paper.destroy

    redirect_to papers_url
  end

  private

  def notify_excited_organizers
    PapersMailer.created(@paper.title, paper_url(@paper)).deliver
  end

  def paper_params
    params.require(:paper).permit(:title, :public_description, :private_description, :time_slot)
  end

end
