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
    survey = self
    choice_rankings = []
    self.choices.each { |choice|
      choice_rankings.push(choice.rankings)}
    extracting_firsts(choice_rankings, survey)
  end

  def extracting_firsts(choice_rankings, survey)
    #byebug
    first_choice_rankings = []
    choice_rankings.each { |choice_ranking|
      first_choice_rankings.push(choice_ranking.where(value: 1))}
     test_for_majority(first_choice_rankings, choice_rankings, survey)
  end

  def test_for_majority(first_choice_rankings, choice_rankings, survey)
    winning_array = []
    first_choice_rankings.each { |first_choice_ranking|
    if first_choice_ranking.length > 0.5 * self.responses.count
      winning_array.push(first_choice_ranking[0])
    end}
    if winning_array.length == 0
      last_choice_rankings(choice_rankings, survey)
    else
      declare_winner(winning_array, survey)
    end
  end

  def declare_winner(winning_array, survey)
    choice_id = winning_array[0]["choice_id"]
    @choice = Choice.find(choice_id)
    byebug
  end

  def last_choice_rankings(choice_rankings, survey)
    byebug
  end

  #  first_choice_rankings = []
  #  choice_rankings.each { |choice_ranking|
  #  first_choice_rankings.push(ranking_array.where(value: 1)}
  #  winning_array = []
  #  first_choice_rankings.each { |first_choice|
  #    if first_choice.length > 0.5 * self.threshold
  #      winning_array.push(first_choice)
  #    end
  #  }
  #    winning_array
  #

    #end


end
