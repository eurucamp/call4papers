class Paper < ActiveRecord::Base
  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates_presence_of :id, :title, :private_description

  def updated?
    created_at != updated_at
  end
end
