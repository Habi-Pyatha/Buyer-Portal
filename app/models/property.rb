# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  address     :string
#  created_at  :datetime         not null
#  description :text
#  image_url   :string
#  price       :decimal
#  title       :string
#  updated_at  :datetime         not null
#
class Property < ApplicationRecord
  has_many :favourites, dependent: :destroy
  has_many :favourited_by, through: :favourites, source: :user

  validates :address, presence: true
  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }

  def self.search(query)
    if query.present?
      where("title LIKE ? OR description LIKE ? OR CAST(price AS TEXT) LIKE ?",
            "%#{query}%", "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
