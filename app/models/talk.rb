class Talk < ActiveRecord::Base
  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  validates :id, :title, :public_description, :time_slot, presence: true
end
