class Api::V1::ChoicesController < ApplicationController


private
  def choice_params
    param.require(:choice).permit(:content, :score, :survey_id)
  end

end