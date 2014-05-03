class RatingDimension < ActiveRecord::Base
  has_many :ratings, inverse_of: :rating_dimension, dependent: :destroy
  validates_uniqueness_of :name
end
