module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorize, only:[:index,:create]
      def index
        users = User.all
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        render json: user
      end

      def create
        user = User.new(user_param)
        if user.save
          token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
          render json: {data: user, message: "User Created Successfully", token:token}, status: :ok
        else
          render json: {data: user.errors, message: "User not created"}, status: :unprocessable_entity
        end
      end

      def update
        user = User.find(params[:id])
        if user.update(user_param)
          render json: {message: "User Updated"}, status: :ok
        else
          render json: {data: user.errors, message: "User not Updated"}, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy()
          render json: {message: "User Deleted"}, status: :ok
        else
          render json: {data: user.errors, message: "User not Deleted"}, status: :unprocessable_entity
        end
      end

      private
      def user_param
        params.permit(:first_name, :last_name, :email, :password)
      end
    end
  end
end
