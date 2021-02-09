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
    if @survey.save

      @choices = @survey.choices.build([{content: params["choiceAContent"], score: params["choiceAInitialScore"]}, {content: params["choiceBContent"], score: params["choiceBInitialScore"]}, {content: params["choiceCContent"], score: params["choiceCInitialScore"]}, {content: params["choiceDContent"], score: params["choiceDInitialScore"]}])
      #byebug
      @choices.each {|choice|
        choice.save}
      #byebug
      options = {
        include: [:choices]
      }
      render json: SurveySerializer.new(@survey, options), status: :accepted
    else
      render json: { errors: @survey.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
    def survey_params
      params.require(:survey).permit(:name, :user_id, choices_attributes: [:content, :score, :survey_id])
    end

end
