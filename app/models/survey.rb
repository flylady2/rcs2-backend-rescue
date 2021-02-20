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
      remove_least_popular_choice(first_choice_rankings, survey)
    else
      declare_winner(winning_array, survey)
    end
  end

  def remove_least_popular_choice(first_choice_rankings, survey)
    first_choice_rankings_lengths = []
    first_choice_rankings.each { |choice_ranking|
      first_choice_rankings_lengths.push(choice_ranking.length)}
    #byebug
    index_of_least_popular_choice = first_choice_rankings_lengths.index(first_choice_rankings_lengths.min)
    #byebug
    rankings_for_least_popular_choice = first_choice_rankings[index_of_least_popular_choice]
    #byebug
    #identify responses to be updated
    ids_of_responses_to_be_updated = []
    rankings_for_least_popular_choice.each { |ranking|
      response_id = ranking.response_id
      ids_of_responses_to_be_updated.push(response_id)}

    #identify and delete choice and associated rankings
    #byebug
    choice_id = rankings_for_least_popular_choice[0]["choice_id"]
    @choice = Choice.find(choice_id)
    @choice.destroy

    #collect responses (minus deleted rankings) to be updated
    responses_to_be_updated = []
    ids_of_responses_to_be_updated.each { |id|
      response = Response.find(id)
      responses_to_be_updated.push(response)}
    create_params(responses_to_be_updated)
  end

  #create params for updating responses rankings
  def create_params(responses_to_be_updated)
    
      rankings_to_be_updated = []
      responses_to_be_updated.each { |response|
        response.rankings.each { |ranking|
          response_id = ranking.response_id
          response = Response.find(response_id)
          ranking_id = ranking.id
          ranking_value = ranking.value
          params = { rankings_attributes: [{id: "#{ranking_id}", value: "#{ranking_value - 1}"}]}
          response.update(params)}
        }
    end


  def declare_winner(winning_array, survey)
    choice_id = winning_array[0]["choice_id"]
    @choice = Choice.find(choice_id)
    byebug
  end



    def response_attributes(response_params)
      response = Response.find(response_params)
      self.response = response if response.valid?
    end



end
