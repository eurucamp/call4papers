class Talk < ActiveRecord::Base
  has_many :proposals, dependent: :destroy
  has_many :calls, through: :proposals

  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates :id, :title, :public_description, :time_slot, presence: true
  validates :user, presence: true
  validates_acceptance_of :terms_and_conditions, if: -> { new_record? }
  attr_accessor :terms_and_conditions

  accepts_nested_attributes_for :user, update_only: true

  def editable?
    proposals.all?(&:call_open?)
  end
end
