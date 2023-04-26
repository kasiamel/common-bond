class List < ApplicationRecord
  has_many :list_elements, dependent: :destroy
  has_many :list_users, dependent: :destroy
  has_many :users, through: :list_users
end
