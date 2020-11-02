class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :comment
  has_one :purchases

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :info, length: { maximum: 1000 }
    validates :category_id, numericality: { greater_than: 1 }
    validates :sales_status_id, numericality: { greater_than: 1 }
    validates :shipping_fee_status_id, numericality: { greater_than: 1 }
    validates :item_prefecture_id, numericality: { greater_than: 1 }
    validates :scheduled_delivery_id, numericality: { greater_than: 1 }
    validates :price, inclusion: { in: (300..9_999_999) }, numericality: { only_integer: true }
  end

  validates :image, presence: true, unless: :was_attached?
  def was_attached?
    image.attached?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :item_prefecture
  belongs_to_active_hash :scheduled_delivery

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :item_prefecture_id
    validates :scheduled_delivery_id
  end
end
