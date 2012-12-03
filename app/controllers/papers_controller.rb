class PapersController < ApplicationController
  skip_before_filter :authenticate, :only => :show

  def index
    @papers = current_user.papers.order("created_at DESC").all
  end

  def show
    @paper = Paper.find(params[:id])
  end

  def new
    @paper = current_user.papers.new
  end

  def edit
    @paper = current_user.papers.find(params[:id])
  end

  def create
    @paper = current_user.papers.new(params[:paper])

    if @paper.save
      notify_excited_organizers
      redirect_to @paper, notice: "Great job! You've successfully propsed a paper for wroc_love.rb conference."
    else
      render :new
    end
  end

  def update
    @paper = current_user.papers.find(params[:id])

    if @paper.update_attributes(params[:paper])
      redirect_to @paper, notice: "Well done! Your proposal has been updated."
    else
      render :edit
    end
  end

  def destroy
    @paper = current_user.papers.find(params[:id])
    @paper.destroy

    redirect_to papers_url
  end

  protected

  def notify_excited_organizers
    PapersMailer.created(@paper.title, paper_url(@paper)).deliver
  end
end
