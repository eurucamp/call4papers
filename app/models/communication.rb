class Communication < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  has_and_belongs_to_many :recipients,
                          class_name: "User",
                          join_table: :communications_recipients,
                          association_foreign_key: :recipient_id

  validates_presence_of :sender, :subject, :body, :recipients
end
