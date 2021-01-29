class SurveySerializer

  include FastJsonapi::ObjectSerializer
  attributes :name, :user_id
  has_many :choices
  has_many :responses
end
