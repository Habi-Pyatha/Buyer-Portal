class Property < ApplicationRecord
  has_many :favourites, dependent: :destroy
  has_many :favourited_by, through: :favourites, source: :user
end
