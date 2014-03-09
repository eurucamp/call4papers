class ProposedSpeaker < ActiveRecord::Base

  belongs_to :inviter, class_name: User
  belongs_to :call

  validates_presence_of :speaker_name, :speaker_email

  delegate :title, to: :call, prefix: true
  delegate :name, :email, :id, to: :inviter, prefix: true
end
