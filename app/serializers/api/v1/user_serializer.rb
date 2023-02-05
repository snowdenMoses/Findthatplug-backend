class UserSerializer < ActiveModel::Serializer
  has_many :products
  attributes :id, :first_name, :last_name, :email, :products
end
