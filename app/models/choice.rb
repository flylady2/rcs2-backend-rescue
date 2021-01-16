class Choice < ApplicationRecord

  belongs_to :survey
  has_many :rankings, dependent: :destroy
  has_many :responses, through: :rankings

end
