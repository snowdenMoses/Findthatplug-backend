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
    # [1, 2, 3].each do |n|
    #   text = "Current number is: #{n}"
    #   puts text
    # end
    params[:categories].each do |element|
      category = Category.find(element.to_i)
      product.categories << category
    end
    product.user = current_user
    if product.save
      render json: {data: params[:categories], message: "Product Successfully Added"}, status: :ok
    else
      render json: {data: product.errors, message: "Product not created"}, status: :unprocessable_entity
    end
end

private

def payload
  params.permit(:name, :description, :price, :user_id, :categories)
end
end
