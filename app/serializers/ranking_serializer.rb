class RankingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :value, :response_id, :choice_id

end
