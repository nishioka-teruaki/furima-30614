class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_add

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_prefecture

end
