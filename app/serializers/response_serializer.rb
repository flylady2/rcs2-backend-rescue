class ResponseSerializer

  include FastJsonapi::ObjectSerializer
  attributes :token, :survey_id
  has_many :rankings
  has_many :choices, through: :rankings

end
