class Talk < ActiveRecord::Base
  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end
end
