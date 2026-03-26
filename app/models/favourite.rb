# == Schema Information
#
# Table name: favourites
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  property_id :integer          not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_favourites_on_property_id  (property_id)
#  index_favourites_on_user_id      (user_id)
#
# Foreign Keys
#
#  property_id  (properties.id)
#  user_id      (users.id)
#
class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :user_id, uniqueness: { scope: :property_id }
end
