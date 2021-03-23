class SurveySerializer

  include FastJsonapi::ObjectSerializer
  attributes :name, :user_email, :choices, :responses
  has_many :choices
  has_many :responses
end
