class CategoriesController < ApplicationController
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
    if(category.save)
      render json: {message: "Category Created"}, status: :ok
    else
      render json: {message: "Category Not Created"}, status: :unprocessable_entity
    end
  end

  private
  def category_payload
    params.permits(:name)
  end

end
