class ProductsSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :name, :description, :price, :categories
end
