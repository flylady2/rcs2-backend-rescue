class ResponseSerializer

  include FastJsonapi::ObjectSerializer
  attributes :respondent, :survey_id
  has_many :rankings

end
