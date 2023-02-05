class ApplicationController < ActionController::API
  before_action :authorize, except: [:index]

  # Decode jwt and authorize if the http request has a token
  def authorize
    @headers = request.headers
    if @headers['Authorization'].present?
      token = @headers['Authorization'].split(' ').last
      decoded_token = decode(token)
      @user = User.find_by(id:decoded_token[:user_id])
      render json:{ error: 'Not Authorized' }, status:401 unless @user
    else
      render json: { message: 'No Authourization' }, status: 401
    end
  end

  private
  # def encode(payload, exp = 24.hours.from_now)
  #   payload[:exp] = exp.to_i
  #   JWT.encode(payload, Rails.application.secrets.secret_key_base)
  # end
  def decode(token)
    body = JWT.decode(token,Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    render json: { data: 'No Authourization' }, status: 500
  end

  def current_user
end
