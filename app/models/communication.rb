class Communication < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :call, inverse_of: :communications
  has_and_belongs_to_many :recipients,
                          class_name: "User",
                          join_table: :communications_recipients,
                          association_foreign_key: :recipient_id

  validates_presence_of :sender, :subject, :body, :recipients

  delegate :name, :email, to: :sender, prefix: :sender

  def recipients=(text_or_list)
    if text_or_list.is_a?(String) or text_or_list.is_a?(Symbol) then
      if respond_to?("set_recipients_to_#{text_or_list}", true) then
        send("set_recipients_to_#{text_or_list}")
      end
    else
      super
    end
  end

  def sent?
    sent_at.present?
  end

  def recipients_emails
    recipients.pluck(:email)
  end

  class << self
    def possible_recipients
      [:all_users, :call_all_users, :call_empty_profiles]
    end
  end

private
  def validate_presence_of_call
    errors.add(:call, "Call must be set!") if call.blank?
  end

  # -- #recipients= methods --
  def set_recipients_to_all_users
    self.recipients = User.all
  end

  def set_recipients_to_call_all_users
    validate_presence_of_call
    if call then
      self.recipients = User.in_call(call)
    end
  end

  def set_recipients_to_call_empty_profiles
    validate_presence_of_call
    if call then
      self.recipients = User.empty_profile.in_call(call)
    end
  end
end
