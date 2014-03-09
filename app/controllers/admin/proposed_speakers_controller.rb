class Admin::ProposedSpeakersController < Admin::AdminController
  def index
    @proposed_speakers = ProposedSpeaker.order('call_id DESC, inviter_id ASC, created_at DESC')
  end

  def export
    @proposed_speakers = ProposedSpeaker.order('call_id DESC, inviter_id ASC, created_at DESC')

    respond_to do |format|
      format.csv do
        csv_response = build_csv(@proposed_speakers, export_columns)
        send_data(csv_response, filename: 'proposed_speakers.csv', disposition: 'attachment', type: 'text/csv; charset=utf-8; header=present')
      end
    end
  end

  private

  def export_columns
    # Handle call_id, user_id (when deanonymized)
    %w(
      id
      call_title
      inviter_name
      inviter_email
      inviter_id
      speaker_name
      speaker_email
      reason
      created_at
    )
  end

end
