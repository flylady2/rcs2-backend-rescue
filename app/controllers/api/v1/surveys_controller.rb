class Api::V1::SurveysController < ApplicationController

  def index
    @surveys = Survey.all
    options = {
      include: [:choices, :responses]
    }
    render json: { surveys: SurveySerializer.new(@surveys, options)}
  end

  

end
