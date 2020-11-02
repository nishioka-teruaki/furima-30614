class PurchasesShippingAdd
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :addresses, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :phone_number, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    
  end

  validates :building, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    purchases = Purchases.create(
      item: item, 
      user: user
    )
    ShippingAdd.create(
      postal_code: postal_code, 
      prefecture_id: prefecture_id, 
      city: city, 
      addresses: addresses, 
      building: building, 
      phone_number: phone_number, 
      purchase: purchase, #要確認
      purchases_id: purchases #要確認
    )
  end
end
