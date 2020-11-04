class PurchasesShippingAdd
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :purchase_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A[0-9]{11}\z/ }
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    purchases = Purchase.create(
      item_id: item_id,
      user_id: user_id
    )
    # binding.pry
    ShippingAdd.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      purchase_id: purchases.id
    )
  end
end
