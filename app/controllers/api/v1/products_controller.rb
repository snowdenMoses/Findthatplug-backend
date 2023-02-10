class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.includes(:categories).all
    render json: products
    end
  def show
    product = Product.find_by(id: params[:id])
    render json: {data: product, prod_cat: product.categories}
  end
  def create
    product = Product.new(payload)
    # mappedArray = params[:categories].map { |num| num }
    # category = Category.find_by(id: params[:categories])
    product.categories << params[:categories]
    product.user = current_user

    if product.save
      render json: {data: product, message: "Product Successfully Added"}, status: :ok
    else
      render json: {data: product.errors, message: "Product not created"}, status: :unprocessable_entity
    end
end

private

def payload
  params.permit(:name, :description, :price, :user_id, :categories)
end
end
