# models/user.rb

class User < ActiveRecord::Base
  has_secure_password
  has_many :jokes
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
