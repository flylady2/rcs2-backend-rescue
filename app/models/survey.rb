class Survey < ApplicationRecord

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :rankings, through: :responses
  #not sure about this one:
  has_many :rankings, through: :choices

  accepts_nested_attributes_for :choices

  #validates :name, uniqueness: { case_sensitive: false}

  def count_responses
    if self.responses.count == self.threshold
      calculate_winner(self)
    end
  end


end
