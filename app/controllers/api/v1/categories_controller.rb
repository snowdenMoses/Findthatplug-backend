class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authorize, only:[:create]
  
  def index
    categories = Category.all
    render json: {data: categories}, status: :ok
  end

  def show
    category = Category.find_by(id: params[:id])
    render json: {data: category}, status: :ok
  end

  def create
    category = Category.new(category_payload)
    if category.save
      render json: {message: "Category Created Successfully"}, status: :ok
    else
      render json: {data: user.errors, message: "Category Not Created"}, status: :unprocessable_entity
    end
  end

 def destroy
        category = Category.find(params[:id])
        if category.destroy()
          render json: {message: "Category Deleted Successfully"}, status: :ok
        else
          render json: {data: category.errors, message: "Category not Deleted"}, status: :unprocessable_entity
        end
  end

  def update
      category = Category.find(params[:id])
      if category.update(category_payload)
        render json: {message: "Category Updated"}, status: :ok
      else
        render json: {data: category.errors, message: "Category not Updated"}, status: :unprocessable_entity
      end
  end

  private
  def category_payload
    params.permit(:name)
  end

end
