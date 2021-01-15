class Survey < ApplicationRecord

  belongs_to :user
  has_many :choices
  has_many :responses
  has_many :rankings, through: :responses
  #not sure about this one:
  has_many :rankings, through: :choices

  validates :name, uniqueness: { case_sensitive: false}

end
