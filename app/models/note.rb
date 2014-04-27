class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper

  validates_presence_of :user, :paper, :content
end
