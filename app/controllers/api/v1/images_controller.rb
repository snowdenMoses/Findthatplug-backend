class Api::V1::ImagesController < ApplicationController
  def show
    image = Image.find_by(id:params[:id])
    render json: image
  end

  def index
    images = Image.all
    render json: images
  end
end
