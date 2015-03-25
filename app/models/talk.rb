class Talk < ActiveRecord::Base
  has_many :proposals, dependent: :destroy
  has_many :calls, through: :proposals

  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates :id, :title, :public_description, :private_description, :time_slot, presence: true
  validates :user, presence: true
  validates_acceptance_of :terms_and_conditions, if: -> { new_record? }
  validates :calls, length: { minimum: 1 }
  attr_accessor :terms_and_conditions

  scope :not_from, -> user { where.not('user_id': user.id) }
  scope :for_open_call, -> { joins(:calls).merge(Call.open) }
  scope :mentors_can_read, -> { where('mentors_can_read': true) }

  accepts_nested_attributes_for :user, update_only: true

  def updated?
    created_at != updated_at
  end

  def editable?
    proposals.all?(&:call_open?)
  end
end
