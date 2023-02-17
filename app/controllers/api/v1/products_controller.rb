class Api::V1::ProductsController < ApplicationController
  # skip_before_action :authorize, only:[:create]
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
    categories = JSON.parse(params[:categories])
    categories.each do |element|
      category = Category.find(element.to_i)
      product.categories << category
    end
    product.user = current_user

    #upload Image
    image = params[:images]
    s3_object = S3_BUCKET.object(image.original_filename)
    s3_object.upload_file(image.path, acl: 'public-read')
    image_model = Image.new(image_url: s3_object.public_url)
    image_model.product = product
    image_model.save

    if product.save
      render json: {product:product, image_url: s3_object.public_url, message: "Product Successfully Added"}, status: :ok
    else
      render json: {data: product.errors, message: "Product not created"}, status: :unprocessable_entity
    end
  end

  def destroy
        product = Product.find(params[:id])
        if product.destroy()
          render json: {message: "Product Deleted Succesfully"}, status: :ok
        else
          render json: {data: product.errors, message: "Product not Deleted"}, status: :unprocessable_entity
        end
  end

  def update
      product = Product.find(params[:id])
      if product.update(payload)
        render json: {message: "Product Updated Succesfully"}, status: :ok
      else
        render json: {data: product.errors, message: "Product not Updated"}, status: :unprocessable_entity
      end
    end

  private

  def payload
    params.permit(:name, :description, :price, :user_id, :categories=>[],:images=>[])
  end
end
