class Product < ApplicationRecord
  belongs_to :user
  has_many :productcategoyids
  has_many :categories, through: :productcategoyids
end
