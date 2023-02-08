class Product < ApplicationRecord
  belongs_to :user
  # has_and_belongs_to_many :categories
  has_many :product_categories
  has_many :categories, through: :product_categories
end
