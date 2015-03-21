class UserProposalRating < ActiveRecord::Base
  belongs_to :user, inverse_of: :user_proposal_ratings
  belongs_to :proposal, inverse_of: :user_proposal_ratings, touch: true
  has_many :ratings, inverse_of: :user_proposal_rating, dependent: :destroy

  validates_uniqueness_of :proposal_id, scope: :user_id
  validate :call_must_be_closed

  accepts_nested_attributes_for :ratings

  def rating_for_rating_dimension(dimension)
    dimension_id = dimension.is_a?(RatingDimension) ? dimension.id : dimension
    rating = self.ratings.find{|rating| rating.rating_dimension_id == dimension_id }
    rating ||= self.ratings.new(rating_dimension_id: dimension_id)
  end

private
  def call_must_be_closed
    errors.add(:proposal, 'Proposal call must be closed!') if proposal.try(:call_open?)
  end
end
