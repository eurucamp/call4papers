class User < ActiveRecord::Base
  attr_accessible :name, :email, :bio, :website_url, :twitter_handle, :github_handle

  validates :name, presence: true
  validates :email, presence: true
end
