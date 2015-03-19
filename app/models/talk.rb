class Talk < ActiveRecord::Base
  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates :id, :title, :public_description, :time_slot, presence: true
  validates :user, presence: true
end
