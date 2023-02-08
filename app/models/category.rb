class Category < ApplicationRecord
  # has_and_belongs_to_many :products
  has_many :product_categories
  has_many :products, through: :product_categories
end
