class ProposalsController < ApplicationController
  skip_before_filter :authenticate, only: :show

  def index
    @proposals = current_user.proposals.order("created_at DESC")
    @open_calls = Call.open
  end

  def show
    @proposal = Talk.find(params[:id]).proposals.first
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
    talk = current_user.talks.find(params[:id])
    @proposal = talk.proposals.first
  end

  def create
    @call  = Call.find(params[:call_id])
    @talk = current_user.talks.new(talk_params)
    @proposal = @talk.proposals.new
    @proposal.call_id = @call.id
    @talk.track = 'Test'

    if @talk.save
      notify_excited_organizers
      redirect_to @proposal, notice: I18n.t('papers.create.success')
    else
      render :new
    end
  end

  def update
    talk = current_user.talks.find(params[:id])
    @proposal = talk.proposals.first

    if talk.update_attributes(talk_params)
      redirect_to @proposal, notice: I18n.t('papers.update.success')
    else
      render :edit
    end
  end

  def destroy
    proposal = current_user.talks.find(params[:id])
    proposal.destroy

    redirect_to proposals_url
  end

  private

  def notify_excited_organizers
    #ProposalsMailer.created(@talk.title, proposal_url(@talk.proposal)).deliver_now
  end

  def talk_params
    params.require(:talk).permit(
      :title, :public_description, :private_description, :time_slot,
      :mentor_name, :mentors_can_read, :terms_and_conditions,
      user_attributes: [:gender, :mentor, :bio]
    )
  end
end
