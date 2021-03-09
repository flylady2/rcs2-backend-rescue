class Ranking < ApplicationRecord
  belongs_to :response
  belongs_to :choice

  validates :response_id, presence: true

  #def search_by_value(@rankings)
  #  number_one_ranking = @rankings.where(value: 1)
    #byebug
  #end
end
