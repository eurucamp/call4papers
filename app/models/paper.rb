class Paper < ActiveRecord::Base
  set_primary_key :id
  validates_presence_of :id, :email, :bio, :description
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, :allow_blank => true, :if => :email_changed?

  before_validation :on => :create do
    self.id = SecureRandom.hex(16)
  end

  attr_accessible :email, :bio, :description

end
