class Paper < ActiveRecord::Base
  EDITABLE_TRACKS = ['JRubyConf EU']

  self.primary_key = 'id'

  before_validation on: :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates_presence_of :id, :title, :private_description, :time_slot, :track

  scope :editable, where(track: EDITABLE_TRACKS)

  def editable?
    EDITABLE_TRACKS.include?(track)
  end

  def updated?
    created_at != updated_at
  end
end
