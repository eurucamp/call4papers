class Talk < ActiveRecord::Base
  has_many :proposals, dependent: :destroy

  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates :id, :title, :public_description, :time_slot, presence: true
  validates :user, presence: true
  validates_acceptance_of :terms_and_conditions, if: -> { new_record? }
  attr_accessor :terms_and_conditions

  #TODO: Need to get related proposal and decide
  def editable?
    false
  end
end
