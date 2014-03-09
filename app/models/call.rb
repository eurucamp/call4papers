class Call < ActiveRecord::Base
  validates :title, :closes_at, presence: true
  validates :title, uniqueness: true

  has_many :papers
  has_many :proposed_speakers

  def self.open(now = Time.zone.now)
    where('closes_at >= ? AND (opens_at IS NULL OR opens_at <= ?)', now, now)
  end

  def open?(now = Time.zone.now)
    closes_at >= now && (opens_at.nil? || opens_at <= now)
  end
end
