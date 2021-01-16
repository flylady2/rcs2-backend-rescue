class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: { users: UserSerializer.new(@users)}
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: UserSerializer.new(@user)}, status: :created
    else
      render json: { errors: @user.erros.full_messages}, status: :unprocessable_entity
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end


end
