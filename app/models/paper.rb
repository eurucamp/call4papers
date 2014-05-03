class Paper < ActiveRecord::Base
  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user
  belongs_to :call
  has_many :user_paper_ratings, inverse_of: :paper, dependent: :destroy

  validates :id, :title, :public_description, :time_slot, presence: true
  validates :call, :user, presence: true
  validates_acceptance_of :terms_and_conditions, if: -> { new_record? }

  scope :for_open_call, -> { joins(:call).merge(Call.open) }
  scope :editable, -> { for_open_call.readonly(false) }
  scope :mentors_can_read, -> { where(mentors_can_read: true) }
  scope :not_from, -> user { where.not(user_id: user.id) }
  scope :selected, -> { where(selected: true) }

  delegate :title, :open?, to: :call, prefix: :call

  accepts_nested_attributes_for :user, update_only: true

  attr_accessor :terms_and_conditions

  def editable?
    call_open?
  end

  def updated?
    created_at != updated_at
  end
end
