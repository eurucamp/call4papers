class User < ActiveRecord::Base
  GENDERS = ["male", "female", "unspecified"]

  has_many :authentications, dependent: :destroy
  has_many :talks, dependent: :destroy
  has_many :proposals, through: :talks
  has_many :proposed_speakers, foreign_key: :inviter_id, dependent: :destroy
  has_and_belongs_to_many :communications,
                          foreign_key: :recipient_id,
                          join_table: :communications_recipients
  has_many :notes
  has_many :user_proposal_ratings, inverse_of: :user, dependent: :destroy

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :mentor, inclusion: { in: [true, false] }

  scope :staff,       -> { where(staff: true) }
  scope :contributor, -> { where(staff: nil)  }
  scope :mentor,      -> { where(mentor: true) }
  scope :empty_profile, -> { where("users.bio IS NULL OR TRIM(users.bio) = ''") }

  def apply_omniauth(omniauth)
    provider, uid, info = omniauth.values_at('provider', 'uid', 'info')
    self.email = info['email'] if email.blank?
    self.name  = info['name']  if name.blank?

    apply_provider_handle(omniauth)
    authentications.build(provider: provider, uid: uid)
  end

  def apply_provider_handle(omniauth)
    provider, info = omniauth.values_at('provider', 'info')

    case provider
    when /github/
      self.github_handle  = info['nickname'] if github_handle.blank?
    when /twitter/
      self.twitter_handle = info['nickname'] if twitter_handle.blank?
    end
  end

  def password_required?
    (authentications.empty? || password.present?) && super
  end

  def connected_with_twitter?
    authentications.where(provider: 'twitter').first
  end

  def connected_with_github?
    authentications.where(provider: 'github').first
  end

  def can_edit_proposal?(proposal)
    proposals.exists?(proposal.id)
  end

  def has_bio?
    ! bio.blank?
  end

  def has_proposal?
    ! proposals.empty?
  end

  # NOTE: Apparently, activerecord adds #staff? and #mentor? methods
  # It's probably best to leave them here for the sake of clarity

  def staff?
    read_attribute(:staff) || false
  end

  def mentor?
    read_attribute(:mentor) || false
  end

  def gender=(gender)
    write_attribute(:gender, GENDERS.index(gender))
  end

  def gender
    GENDERS[read_attribute(:gender)] if read_attribute(:gender)
  end

  class << self
    def in_call(call)
      call_id = call.is_a?(Call) ? call.id : call
      where(id: Proposal.where(call_id: call_id).select(:user_id))
    end

    def with_selected_proposals_for(call)
      self.in_call(call).where('proposals.selected = ?', true)
    end
  end

  def note_for_proposal(proposal)
    notes.where(proposal_id: proposal.id).first || Note.new
  end

  def user_proposal_rating_for_proposal(proposal)
    proposal_id = proposal.is_a?(Proposal) ? proposal.id : proposal
    self.user_proposal_ratings.where(proposal_id: proposal).first_or_initialize
  end
end
