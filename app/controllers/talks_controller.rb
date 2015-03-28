class TalksController < ApplicationController
  skip_before_filter :authenticate, only: :show

  def index
    @talks = current_user.talks.order("created_at DESC")
    @open_calls = Call.open
  end

  def show
    @talk = Talk.find(params[:id])
  end

  def new
    @talk = current_user.talks.new
    @open_calls = Call.open
  end

  def edit
    @talk = current_user.talks.find(params[:id])
    @open_calls = Call.open
  end

  def create
    @talk = current_user.talks.new(talk_params.except(:user_attributes))
    @talk.track = 'Test'
    if @talk.save
      if talk_params[:user_attributes]
        @talk.user_attributes = talk_params[:user_attributes]
      end
      if @talk.save
        notify_excited_organizers
        redirect_to @talk, notice: I18n.t('papers.create.success')
      else
        @open_calls = Call.open
        render :new
      end
    else
      @open_calls = Call.open
      render :new
    end
  end

  def update
    @talk = current_user.talks.find(params[:id])

    if @talk.update_attributes(talk_params)
      redirect_to @talk, notice: I18n.t('papers.update.success')
    else
      render :edit
    end
  end

  def destroy
    talk = current_user.talks.find(params[:id])
    talk.destroy

    redirect_to talks_url
  end

  private

  def notify_excited_organizers
    ProposalsMailer.created(@talk.title, talk_url(@talk)).deliver_now
  end

  def talk_params
    params.require(:talk).permit(
      :title, :public_description, :private_description, :time_slot,
      :mentor_name, :mentors_can_read, :terms_and_conditions,
      user_attributes: [:gender, :mentor, :bio],
      call_ids: []
    )
  end
end
