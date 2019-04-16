class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: login_params[:username])
    if @user&.authenticate(login_params[:password])
      token = encode_token(user_id: @user.id)
      # Or perhaps just render the token
      render json: { user: @user, jwt: token }, status: :accepted
    else
      render json: { message: 'Invalid login details' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
