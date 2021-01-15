class Response < ApplicationRecord

  belongs_to :survey
  validates :respondent, uniqueness: { case_sensitive: false}

end
