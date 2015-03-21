class ProposalsController < ApplicationController
  skip_before_filter :authenticate, only: :show

  def index
    @proposals = current_user.proposals.order("created_at DESC")
    @open_calls = Call.open
  end

  def show
    @proposal = Proposal.find(params[:id])
    if current_user
      @user_proposal_rating = current_user.user_proposal_rating_for_proposal(@proposal)
    end
  end

  def new
    @call  = Call.find(params[:call_id])
    @proposal = current_user.proposals.new
    @proposal.build_talk
  end

  def edit
    @proposal = current_user.proposals.editable.find(params[:id])
  end

  def create
    @call  = Call.find(params[:call_id])
    @proposal = current_user.proposals.new(proposal_params)
    @proposal.build_talk unless @proposal.talk
    @proposal.call  = @call
    @proposal.track = 'Test'

    if @proposal.save
      notify_excited_organizers
      redirect_to @proposal, notice: I18n.t('papers.create.success')
    else
      render :new
    end
  end

  def update
    @proposal = current_user.proposals.editable.find(params[:id])

    if @proposal.update_attributes(proposal_params)
      redirect_to @proposal, notice: I18n.t('papers.update.success')
    else
      render :edit
    end
  end

  def destroy
    @proposal = current_user.proposals.editable.find(params[:id])
    @proposal.destroy

    redirect_to proposals_url
  end

  private

  def notify_excited_organizers
    ProposalsMailer.created(@proposal.title, proposal_url(@proposal)).deliver_now
  end

  def proposal_params
    params.require(:proposal).permit(
      :title, :public_description, :private_description, :time_slot,
      :mentor_name, :mentors_can_read, :terms_and_conditions,
      user_attributes: [:gender, :mentor, :bio]
    )
  end

end
