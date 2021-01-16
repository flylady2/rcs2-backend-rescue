class Response < ApplicationRecord

  belongs_to :survey
  has_many :rankings, dependent: :destroy
  has_many :choices, through: :rankings
  validates :respondent, uniqueness: { case_sensitive: false}

end
