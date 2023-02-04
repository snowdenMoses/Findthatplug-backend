class Api::V1::AuthController < ApplicationController
  skip_before_action :authorize
  # The skip before action makes sure that the authenticate method doesn't get dependent on the authorize method
  def authenticate
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
      render json: {token: token, user_id: user.id}, status: :ok
    else
      render json: {error: 'Invalid credentials'}, status: :unauthorized
    end
  end
end
