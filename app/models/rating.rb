class Rating < ActiveRecord::Base
  belongs_to :user_paper_rating, inverse_of: :ratings
  belongs_to :rating_dimension, inverse_of: :ratings

  validates_presence_of :user_paper_rating, :rating_dimension, :vote
  validates_uniqueness_of :rating_dimension_id, scope: :user_paper_rating_id
  validates_numericality_of :vote, greater_than_or_equal_to: 0, less_than_or_equal_to: 2
end
