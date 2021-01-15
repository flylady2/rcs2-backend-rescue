class Choice < ApplicationRecord

  belongs_to :survey
  has_many :rankings
  
end
