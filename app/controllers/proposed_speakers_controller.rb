class ProposedSpeakersController < ApplicationController

  def index
    @proposed_speakers = current_user.proposed_speakers.order("created_at DESC")
    @open_calls = Call.open
  end

  def new
    @call  = Call.find(params[:call_id])
    @proposed_speaker = current_user.proposed_speakers.new
  end

  def create
    @call  = Call.find(params[:call_id])
    @proposed_speaker = current_user.proposed_speakers.new(proposed_speaker_params)
    @proposed_speaker.call  = @call
    @proposed_speaker.inviter = current_user

    if @proposed_speaker.save
      redirect_to proposed_speakers_path, notice: t('proposed_speakers.create.notice')
    else
      render :new
    end
  end

  def destroy
    @proposed_speaker = current_user.proposed_speakers.find(params[:id])
    @proposed_speaker.destroy

    redirect_to proposed_speakers_url
  end

  private

  def proposed_speaker_params
    params.require(:proposed_speaker).permit(:speaker_name, :speaker_email, :reason)
  end

end
