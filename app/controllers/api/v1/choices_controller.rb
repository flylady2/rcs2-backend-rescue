class Api::V1::ChoicesController < ApplicationController


private
  def choice_params
    params.require(:choice).permit(:content, :score, :survey_id)
  end

end
