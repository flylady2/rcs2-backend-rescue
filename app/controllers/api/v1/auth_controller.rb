class Api::V1::AuthController < ApplicationController
  #Sskip_before_action :authorized, only: [:create]
  wrap_parameters :user, include: [:email, :password]

  def create
    #byebug
    @user = User.find_by(email: user_login_params[:email])
    #byebug
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: token}, status: :accepted
    else
      render json: { message: 'Invalid username or password'}, status: :unauthorized
    end
  end

  #def auto_login
  #  if current_user
  #    render json: {user: UserSerializer.new(@user), jwt: token}, status: :accepted
  #  else
  #    render json: { message: 'Not logged in'}, status: :unauthorized
  #  end
  #end



  private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end
end
