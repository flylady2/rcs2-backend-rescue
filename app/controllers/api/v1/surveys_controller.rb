class Api::V1::SurveysController < ApplicationController

  def index
    @surveys = Survey.all
    options = {
      include: [:choices, :responses]
    }
    render json: { surveys: SurveySerializer.new(@surveys, options)}
  end

  def create
    @survey = Survey.new(survey_params)
  end

  private
    def survey_params
      params.require(:survey).permit(:name, choices_attributes: [:content, :score, :survey_id])
    end

end
