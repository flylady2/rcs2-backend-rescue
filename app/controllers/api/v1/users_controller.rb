class Api::V1::UsersController < ApplicationController
  #skip_before_action :authorized, only: [:create]
  wrap_parameters :user, include: [:username, :email, :password]

  def page
    render json: { user: UserSerializer.new(current_user)}, status: :accepted
  end

  def index
    @users = User.all
    render json: { users: UserSerializer.new(@users)}
  end

  def create
    #byebug
    @user = User.create(user_params)
    #byebug
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      #byebug
    else
      render json: { error: 'failed to create user'}, status: :not_acceptable
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end


end
