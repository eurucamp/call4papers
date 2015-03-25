class Rating < ActiveRecord::Base
  belongs_to :user_proposal_rating, inverse_of: :ratings, touch: true
  belongs_to :rating_dimension, inverse_of: :ratings

  validates_presence_of :user_proposal_rating, :rating_dimension, :vote
  validates_uniqueness_of :rating_dimension_id, scope: :user_proposal_rating_id
  validates_numericality_of :vote, greater_than_or_equal_to: 0, less_than_or_equal_to: 2

  scope :in_dimension, -> dimension { where(rating_dimension_id: dimension) }
end
