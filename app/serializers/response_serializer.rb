class ResponseSerializer

  include FastJsonapi::ObjectSerializer
  attributes :respondent, :survey_id
  has_many :rankings
  has_many :choices, through: :rankings

end
