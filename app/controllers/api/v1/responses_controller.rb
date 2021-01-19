class Api::V1::ResponsesController < ApplicationController

private

def response_params
  params.require(:response).permit(:respondent, :survey_id)

end
