class User < ApplicationRecord

  has_many :surveys, dependent: :destroy
  has_many :responses, through: :surveys
  validates :username, uniqueness: { case_sensitive: false}
  validates :email, uniqueness: { case_sensitive: false}
  has_secure_password

end
