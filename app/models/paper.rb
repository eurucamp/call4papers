class Paper < ActiveRecord::Base
  set_primary_key :id

  has_many :upvotes
  has_many :voters, through: :upvotes, source: :user

  before_validation :on => :create do
    self.id = SecureRandom.hex(16)
  end

  belongs_to :user

  validates_presence_of :id, :title, :private_description

  attr_accessible :title, :public_description, :private_description

  scope :with_upvotes, select("papers.id, papers.title, papers.user_id, papers.created_at, papers.updated_at, papers.selected, COUNT(upvotes.id) AS upvote_count").
                        joins("LEFT OUTER JOIN upvotes ON upvotes.paper_id = papers.id").
                        group("papers.id, papers.title, papers.user_id, papers.created_at, papers.updated_at, papers.selected").
                        order("selected DESC, upvote_count DESC, created_at DESC")

  delegate :name, to: :user, prefix: true

  def updated?
    created_at != updated_at
  end

  def upvoted_by?(user)
    voters.include? user
  end
end
