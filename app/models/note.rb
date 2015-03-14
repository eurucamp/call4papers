class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal

  validates_presence_of :user, :proposal, :content
end
