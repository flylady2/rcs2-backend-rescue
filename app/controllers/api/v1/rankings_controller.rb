class Api::V1::RankingsController < ApplicationController

private
  def ranking_params
    params.require(:ranking).permit(:value, :response_id, :choice_id)
  end

end
