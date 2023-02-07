class Category < ApplicationRecord
  has_many :productcategoyids
  has_many :products, through: :productcategoyids
end
