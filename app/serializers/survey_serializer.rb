class SurveySerializer

  include FastJsonapi::ObjectSerializer
  attributes :name
  has_many :choices
  has_many :responses
end
