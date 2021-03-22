class ChoiceSerializer

  include FastJsonapi::ObjectSerializer
  attributes :content, :winner, :survey_id
  has_many :rankings

end
