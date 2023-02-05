class ProductsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price
end
