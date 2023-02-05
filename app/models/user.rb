class User < ApplicationRecord
  has_many :products
  validates :email, presence:true, uniqueness:{case_sensitive: false}
  has_secure_password
end
