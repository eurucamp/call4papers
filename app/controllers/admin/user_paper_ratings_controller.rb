class Admin::UserPaperRatingsController < Admin::AdminController
  before_action :find_paper
  before_action :find_or_initialize_user_paper_rating

  def create
    @user_paper_rating.assign_attributes(user_paper_rating_params)
    if @user_paper_rating.save then
      case params[:commit]
      when /papers list/i
        target = admin_papers_path
      when /next paper/i
        target = Paper.visible.not_rated_by_user(current_user).first
        target ||= 'https://www.youtube.com/watch?v=xvX_5ym_ajI'
      else
        target = @paper
      end
      redirect_to target, notice: "voting successful!"
    else
      render "papers/show"
    end
  end

  alias_method :update, :create

private
  def find_paper
    @paper = Paper.find(params[:id])
    if @paper.call_open?
      redirect_to @paper, notice: "Paper's call is still open!"
    end
  end

  def find_or_initialize_user_paper_rating
    @user_paper_rating = current_user.user_paper_rating_for_paper(@paper)
  end

  def user_paper_rating_params
    params.require(:user_paper_rating).permit(
      ratings_attributes: [:id, :rating_dimension_id, :vote] #, :notes]
    )
  end
end
