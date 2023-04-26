class User < ApplicationRecord
  has_secure_password

  has_many :list_users, dependent: :destroy
  has_many :lists, through: :list_users
end
