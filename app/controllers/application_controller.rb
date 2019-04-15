class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    exp = Time.now.to_i + 3600
    payload.merge!(exp)
    JWT.encode(payload, ENV['SECRET'])
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return nil unless auth_header

    # strict check for 'Authorization': 'Bearer <token>' format
    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, ENV['SECRET'], true, algorithm: 'HS256')
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end
  end

  def current_user
    return nil unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    current_user.is_a?(User)
  end

  def current_admin_user
    current_user&.admin
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
