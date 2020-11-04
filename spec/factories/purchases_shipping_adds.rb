FactoryBot.define do
  factory :purchases_shipping_add do

    token         { 'tok_abcdefghijk00000000000000000' }

    postal_code   { '111-1111' }
    prefecture_id { 2 }
    city          { Gimei.address.city.kanji }
    addresses     { '青山1-1-1' }
    building      { '柳ビル103' }
    phone_number  { '09012341234' }

    association :user
    association :item
  end
end
