class Ranking < ApplicationRecord
  belongs_to :response
  belongs_to :choice

  validates :response_id, presence: true
end
