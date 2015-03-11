class UserPaperRating < ActiveRecord::Base
  belongs_to :user, inverse_of: :user_paper_ratings
  belongs_to :paper, inverse_of: :user_paper_ratings, touch: true
  has_many :ratings, inverse_of: :user_paper_rating, dependent: :destroy

  validates_uniqueness_of :paper_id, scope: :user_id
  validate :call_must_be_closed

  accepts_nested_attributes_for :ratings

private
  def call_must_be_closed
    errors.add(:paper, 'Paper call must be closed!') if paper.try(:call_open?)
  end
end
