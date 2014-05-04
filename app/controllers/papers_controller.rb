class PapersController < ApplicationController
  skip_before_filter :authenticate, only: :show

  def index
    @papers = current_user.papers.order("created_at DESC")
    @open_calls = Call.open
  end

  def show
    @paper = Paper.find(params[:id])
    @user_paper_rating = current_user.user_paper_rating_for_paper(@paper)
  end

  def new
    @call  = Call.find(params[:call_id])
    @paper = current_user.papers.new
  end

  def edit
    @paper = current_user.papers.editable.find(params[:id])
  end

  def create
    @call  = Call.find(params[:call_id])
    @paper = current_user.papers.new(paper_params)
    @paper.call  = @call
    @paper.track = 'Test'

    if @paper.save
      notify_excited_organizers
      redirect_to @paper, notice: I18n.t('papers.create.success')
    else
      render :new
    end
  end

  def update
    @paper = current_user.papers.editable.find(params[:id])

    if @paper.update_attributes(paper_params)
      redirect_to @paper, notice: I18n.t('papers.update.success')
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
    params.require(:paper).permit(
      :title, :public_description, :private_description, :time_slot,
      :mentor_name, :mentors_can_read, :terms_and_conditions,
      user_attributes: [:gender, :mentor, :bio]
    )
  end

end
