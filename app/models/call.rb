class Call < ActiveRecord::Base
  validates :title, :closes_at, presence: true
  validates :title, uniqueness: true

  has_many :papers
end
