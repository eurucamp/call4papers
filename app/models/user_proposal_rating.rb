class UserProposalRating < ActiveRecord::Base
  belongs_to :user, inverse_of: :user_proposal_ratings
  belongs_to :proposal, inverse_of: :user_proposal_ratings, touch: true
  has_many :ratings, inverse_of: :user_proposal_rating, dependent: :destroy

  validates_uniqueness_of :proposal_id, scope: :user_id
  validate :call_must_be_closed

  accepts_nested_attributes_for :ratings

private
  def call_must_be_closed
    errors.add(:proposal, 'Proposal call must be closed!') if proposal.try(:call_open?)
  end
end
