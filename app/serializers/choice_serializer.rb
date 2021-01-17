class ChoiceSerializer

  include FastJsonapi::ObjectSerializer
  attributes :content, :score, :survey_id
  has_many :rankings

end
