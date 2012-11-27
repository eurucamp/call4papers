class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :bio, :website_url, :twitter_handle, :github_handle,
                  :password, :password_confirmation, :remember_me

  validates :name, presence: true
  validates :email, presence: true
end
