class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  # validates_presence_of :password
  has_secure_token :api_key

  has_secure_password
end