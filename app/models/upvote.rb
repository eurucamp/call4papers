class Upvote < ActiveRecord::Base
  belongs_to :paper
  belongs_to :user
end
