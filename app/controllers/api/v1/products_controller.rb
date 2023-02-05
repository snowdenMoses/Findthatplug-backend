class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products
  end

  def show

  end
def create
  product = Product.new(payload)
  product.user = current_user

  if product.save
    render json: product, status: :ok
  else
    render json: {data: product.errors, message: "Product not created"}, status: :unprocessable_entity
  end
end

private

def payload
  params.permit(:name, :description, :price)
end
end
