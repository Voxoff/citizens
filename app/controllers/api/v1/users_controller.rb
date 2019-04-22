class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    email = user_params[:email]
    username = user_params[:username]
    user = User.find_by(email: email) if email
    user = User.find_by(username: username) if username && user.nil?

    if user
      render json: { user: user }, status: :accepted
    else
      render json: { message: 'The user could not be found' }, status: :not_found
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: @user, jwt: @token }, status: :created
    else
      render json: { error: 'Failed to create user' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
