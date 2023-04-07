class List < ApplicationRecord
  has_many :elements, dependent: :destroy
end
