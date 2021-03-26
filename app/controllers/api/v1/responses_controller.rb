class Api::V1::ResponsesController < ApplicationController

def emails

  UserMailer.with(survey_name: params["survey_name"], respondent_email: params["respondent_email"], response_link: params["response_link"]).invite_response.deliver_now
end

  def index
    @responses = Response.all
    options = {
      include: [:choices, :rankings]
    }
    render json: { responses: ResponseSerializer.new(@responses, options)}
    #byebug
  end

  def create
    if params[:survey_id] && @survey = Survey.find_by_id(params[:survey_id].to_i)#nested uner responses
      @response = @survey.responses.new(response_params)

    end
    @response.save
    #byebug
    if @response
      @rankings = @response.rankings.build([{value: params["ranking1"].to_i, choice_id: params["ranking1_choiceId"].to_i}, {value: params["ranking2"].to_i, choice_id: params["ranking2_choiceId"].to_i}, {value: params["ranking3"].to_i, choice_id: params["ranking3_choiceId"].to_i}, {value: params["ranking4"].to_i, choice_id: params["ranking4_choiceId"].to_i}])


      @rankings.each {|ranking|
        ranking.save}
      @response.response_count
      #byebug
      options = {
        include: [:rankings]
      }

      render json: ResponseSerializer.new(@response, options), status: :accepted

    else
      render json: { errors: @response.errors.full_messages}, status: :unprocessable_entity
    end



  end

  def update
    byebug
  end


private

  def response_params
    params.require(:response).permit(:token, :survey_id, rankings_attributes: [:value, :response_id, :choice_id])
  end
end
