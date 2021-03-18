class Api::V1::SurveysController < ApplicationController

  def index
    #byebug
    #byebug
    #surveys = Survey.all.select { |survey| survey.user_id == current_user.id }
    @surveys = Survey.all
    options = {
      include: [:choices, :responses]
    }
    render json: { surveys: SurveySerializer.new(@surveys, options)}
  end

  def create
    @survey = Survey.new(survey_params)
    #byebug
    if @survey.save

      @choices = @survey.choices.build([{content: params["choiceAContent"], winner: params["choiceAWinnerValue"]}, {content: params["choiceBContent"], winner: params["choiceBWinnerValue"]}, {content: params["choiceCContent"], winner: params["choiceCWinnerValue"]}, {content: params["choiceDContent"], winner: params["choiceDWinnerValue"]}])
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
      params.require(:survey).permit(:name, :user_id, :threshold,  choices_attributes: [:content, :winner, :survey_id])
    end

end
