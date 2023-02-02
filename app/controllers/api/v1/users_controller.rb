module Api
  module V1
    class UsersController < ApplicationController
      # skip_before_action :authorize, only:[:index]
      def index
        users = User.all
        render json: {data: users}, status: :ok
      end

      def show
        user = User.find(params[:id])
        render json: {data: user}, status: :ok
      end

      def get_logged_in_user
        # current_user = User.find(session[:current_user_id])
        # render json: {data: current_user}, status: :ok
      end

      def new
        @user = User.new
      end

      def create
        user = User.new(user_param)
        if user.save
          render json: {data: user, message: "User created"}, status: :ok
        else
          render json: {data: user.errors, message: "User not created"}, status: :unprocessable_entity
        end
      end

      def update
        user = User.find(params[:id])
        if user.update(user_param)
          render json: {data: user, message: "User Updated"}, status: :ok
        else
          render json: {data: user.errors, message: "User not Updated"}, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy()
          render json: {data: user, message: "User Updated"}, status: :ok
        else
          render json: {data: user.errors, message: "User not Updated"}, status: :unprocessable_entity
        end
      end

      private
      def user_param
        params.permit(:first_name, :last_name, :email, :password)
      end
    end
  end
end
