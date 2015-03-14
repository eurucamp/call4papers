class Admin::UserProposalRatingsController < Admin::AdminController
  before_action :find_proposal
  before_action :find_or_initialize_user_proposal_rating

  def create
    @user_proposal_rating.assign_attributes(user_proposal_rating_params)
    if @user_proposal_rating.save then
      case params[:commit]
      when /papers list/i
        target = admin_proposals_path
      when /next paper/i
        target = Proposal.visible.not_rated_by_user(current_user).order('random()').first
        target ||= 'https://www.youtube.com/watch?v=xvX_5ym_ajI'
      else
        target = @proposal
      end
      redirect_to target, notice: "voting successful!"
    else
      render "proposals/show"
    end
  end

  alias_method :update, :create

private
  def find_proposal
    @proposal = Proposal.find(params[:id])
    if @proposal.call_open?
      redirect_to @proposal, notice: "Paper's call is still open!"
    end
    if @proposal.call.deanonymized? then
      redirect_to @proposal, notice: "Paper's call is deanonymized!"
    end
  end

  def find_or_initialize_user_proposal_rating
    @user_proposal_rating = current_user.user_proposal_rating_for_proposal(@proposal)
  end

  def user_proposal_rating_params
    params.require(:user_proposal_rating).permit(
      ratings_attributes: [:id, :rating_dimension_id, :vote] #, :notes]
    )
  end
end
