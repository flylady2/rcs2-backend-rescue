class UserMailer < ApplicationMailer

  def announce_winner
    @choice = params[:winning_choice]
    @survey = params[:survey]
    @user_email = params[:user_email]
    byebug
    mail(to: @user_email, subject: 'Winning Choice')

  end
end
