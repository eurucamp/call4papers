class MoveDataFromProposalToTalk < ActiveRecord::Migration
  def up
    Proposal.find_each do |proposal|
      unless proposal.talk_id.present?
        talk = proposal.build_talk

        talk.user_id             = proposal.read_attribute :user_id
        talk.title               = proposal.read_attribute :title
        talk.public_description  = proposal.read_attribute :public_description
        talk.private_description = proposal.read_attribute :private_description
        talk.time_slot           = proposal.read_attribute :time_slot
        talk.mentor_name         = proposal.read_attribute :mentor_name
        talk.mentors_can_read    = proposal.read_attribute :mentors_can_read

        talk.valid? # Talk#id is generated before_validation…
        talk.save!(validate: false) # validations complain about too few calls
        proposal.save!
      end
    end
  end

  def down
    Talk.find_each do |talk|
      talk.proposals.each do |proposal|
        proposal.user                = talk.user
        proposal.title               = talk.title
        proposal.public_description  = talk.public_description
        proposal.private_description = talk.private_description
        proposal.time_slot           = talk.time_slot
        proposal.mentor_name         = talk.mentor_name
        proposal.mentors_can_read    = talk.mentors_can_read

        proposal.save!
      end
    end
  end
end
