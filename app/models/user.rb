class User < ActiveRecord::Base
  has_many :authentications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :bio, :website_url, :twitter_handle, :github_handle,
                  :password, :password_confirmation, :remember_me

  validates :name, presence: true
  validates :email, presence: true

  def apply_omniauth(omniauth)
    provider, uid, info = omniauth.values_at('provider', 'uid', 'info')
    self.email = info['email'] if email.blank?
    self.name  = info['name']  if name.blank?

    case provider
    when /github/
      self.github_handle = info['nickname'] if github_handle.blank?
    end

    authentications.build(provider: provider, uid: uid)
  end

  def password_required?
    (authentications.empty? || password.present?) && super
  end
end
