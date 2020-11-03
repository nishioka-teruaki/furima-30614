FactoryBot.define do
  factory :purchases_shipping_add do
    postal_code { Faker::Address.postcode }
    prefecture_id            { 2 }
    city { Gimei.address.city.kanji }
    addresses { "青山1-1-1" }
    building { "柳ビル103" }
    phone_number { 19012345678 }

    association :user
    association :item

  end
end