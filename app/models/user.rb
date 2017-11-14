class User < ApplicationRecord
  attr_accessor :remember_token

  before_save do
    email.downcase!
    self.remember_token = User.return_new_remember_token
    self.remember_digest = User.encrypt_token(remember_token)
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: {maximum: 200 }
  validates :password, length: { minimum: 6 }
  has_secure_password


#private ######################################################

  def User.return_new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt_token(string)
    Digest::SHA1.hexdigest(string)
  end

  def remember
    self.remember_token = User.return_new_remember_token
    update_attribute(:remember_digest, User.encrypt_token(remember_token))
  end



end
