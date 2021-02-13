class Survey < ApplicationRecord

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :rankings, through: :responses
  #not sure about this one:
  has_many :rankings, through: :choices

  accepts_nested_attributes_for :choices

  #validates :name, uniqueness: { case_sensitive: false}

  def calculate_winner
    self.choices.each { |choice|
      get_rankings(choice)}
  end

  def get_rankings(choice)
    @rankings = choice.rankings
    search_by_value(@rankings)
  end

  def search_by_value(@rankings)
    number_one_ranking = @rankings.where(value: 1)
  end




end
