class Proposal < ActiveRecord::Base
  has_many :notes
  belongs_to :talk

  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user
  belongs_to :call
  has_many :user_proposal_ratings, inverse_of: :proposal, dependent: :destroy
  has_many :ratings, through: :user_proposal_ratings

  validates :call, :talk, presence: true

  scope :visible, -> { joins(:call).merge(Call.not_archived) }
  scope :for_open_call, -> { joins(:call).merge(Call.open) }
  scope :editable, -> { for_open_call.readonly(false) }
  scope :mentors_can_read, -> { joins(:talk).where('talks.mentors_can_read': true) }
  scope :not_from, -> user { joins(:talk).where.not('talks.user_id': user.id) }
  scope :selected, -> { where(selected: true) }

  delegate :title, :open?, to: :call, prefix: :call
  delegate :title, :public_description, :private_description, :time_slot, :mentor_name, :mentors_can_read, to: :talk, prefix: :talk

  accepts_nested_attributes_for :user, update_only: true

  def editable?
    call_open?
  end

  def updated?
    created_at != updated_at
  end

  def rated_by?(user)
    user_proposal_ratings.where(user_id: user.id).one?
  end

  def note_attached_by?(user)
    notes.where(user_id: user.id).one?
  end

  def score
    sum_of_votes = ratings.sum(:vote)
    sum_of_votes / user_proposal_ratings.size.to_f
  end

  def score_by_dimension(dimension)
    sum_of_votes = ratings.in_dimension(dimension).sum(:vote)
    sum_of_votes / user_proposal_ratings.size.to_f
  end

  class << self
    def not_rated_by_user(user)
      where.not(id: user.user_proposal_ratings.select(:proposal_id))
    end
  end

  def user_email
    talk.user.email
  end

  def user_name
    talk.user.name
  end
end
