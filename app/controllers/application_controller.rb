class ApplicationController < ActionController::API
  before_action :authorize, except: [:index,:authenticate]

  # Decode jwt and authorize if the http request has a token
  def authorize
    @headers = request.headers
    if @headers['Authorization'].present?
      token = @headers['Authorization'].split(' ').last
      decoded_token = decode(token)
      @user = User.find_by(id:decoded_token[:user_id])
      session[:current_user_id] = @user.id
      render json:{ error: 'Not Authorized' }, status:401 unless @user
    else
      render json: { message: 'No Authourization' }, status: 401
    end
  end

  def current_user
    user = User.find_by(id: session[:current_user_id])
  end
  def authenticate
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
      render json: {token: token}, status: :ok
    else
      render json: {error: 'Invalid credentials'}, status: :unauthorized
    end
  end

  def logout
    session[:current_user_id] = ""
  end

  private

  def decode(token)
    body = JWT.decode(token,Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    render json: { data: 'No Authourization' }, status: 500
  end
end
