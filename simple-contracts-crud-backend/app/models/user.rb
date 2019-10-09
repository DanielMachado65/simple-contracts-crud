# user for platform
class User < ApplicationRecord
  has_secure_password

  # relationship
  has_many :contracts

  # validates
  validates :email, presence: true, length: {maximum: 260}, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, uniqueness: {case_sensitive: false}

  # callback
  before_save {self.email = email.downcase}

  def regenerate_token
    update_column(:auth_token, Devise.friendly_token)
  end

  def invalidate_token
    update_column(:auth_token, nil)
  end
end
