class Product < ApplicationRecord
  belongs_to :user
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :images, dependent: :destroy
end
