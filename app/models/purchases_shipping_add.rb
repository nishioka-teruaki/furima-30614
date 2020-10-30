class PurchasesShippingAdd
  include ActiveModel::Model
  attr_accessor :item, :user, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :purchase

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :addresses, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :phone_number, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :purchase
  end

  validates :building, format: { with: /\A[ぁ-んァ-ン一-龥]/ }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_prefecture

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    Purchases.create(item: item, user: user)
    ShippingAdd.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,phone_number: phone_number,purchase: purchase)
  end
end