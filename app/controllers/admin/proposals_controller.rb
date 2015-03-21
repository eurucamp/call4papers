class Admin::ProposalsController < Admin::AdminController
  def index
    @call = Call.find(params[:call_id])
    @dimensions = RatingDimension.all
    @proposals = @call.proposals.visible.joins(:talk).order('selected DESC, track ASC, time_slot ASC, created_at DESC').to_a
    if params[:sort]
      @proposals.sort_by! do |p|
        score = p.score
        if score.nan?
          -1
        else
          score
        end
      end
      @proposals.reverse!
    end
    @proposals = Admin::ProposalDecorator.wrap(@proposals)
  end

  def update
    proposal_parameters = params[:proposal]
    proposal_parameters.permit(:selected)
    @proposal = Proposal.find(params[:id])
    @proposal.selected = proposal_parameters[:selected]
    @proposal.save!
    redirect_to proposal_path(@proposal)
  end

  def export
    @proposals = Proposal.joins(:talk).order('selected DESC, track ASC, talks.time_slot ASC, created_at DESC')

    respond_to do |format|
      format.csv do
        csv_response = build_csv(@proposals, export_columns)
        send_data(csv_response, filename: 'proposals.csv', disposition: 'attachment', type: 'text/csv; charset=utf-8; header=present')
      end
    end
  end

  private

  def export_columns
    # Handle call_id, user_id (when deanonymized)
    %w(
      id
      user_name
      user_email
      talk_title
      talk_public_description
      talk_private_description
      selected
      score
      talk_time_slot
      track
      created_at
      updated_at
    )
  end

end
