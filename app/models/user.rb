class User < ApplicationRecord
  before_save { email.downcase! }    #  before_save { self.email = email.downcase }
  validates :nick, uniqueness: { case_sensitive: true }, length: {maximum: 50}, presence: true
  validates :email, uniqueness: true, presence: true, length: {maximum: 255}, format: {with: URI::MailTo::EMAIL_REGEXP}  #Thành
  
  has_secure_password
  has_many :tasks

end
