class Ranking < ApplicationRecord
  belongs_to :response
  belongs_to :choice
end
