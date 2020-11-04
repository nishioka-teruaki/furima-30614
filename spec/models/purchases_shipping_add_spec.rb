require 'rails_helper'

RSpec.describe PurchasesShippingAdd, type: :model do
  before do
    @user1 = FactoryBot.build(:user)
    @item = FactoryBot.build(:item, user_id: @user1.id)
    @user2 = FactoryBot.build(:user)
    @purchase_shipping_add = FactoryBot.build(:purchases_shipping_add, item_id: @item.id, user_id: @user2.id)
  end

  describe '商品出品登録' do
    context 'すべての値が正しく入力されていれば保存できること' do
      it 'token, postal_code, prefecture_id、city、addresses, building, phone_number, user_id, item_idが存在すれば登録できる' do
        expect(@purchase_shipping_add).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @purchase_shipping_add.building = nil
        expect(@purchase_shipping_add).to be_valid
      end
    end

    context '保存がうまくいかないとき' do
      it 'tokenが空では登録できないこと' do
        @purchase_shipping_add.token = nil
        @purchase_shipping_add.valid?

        expect(@purchase_shipping_add.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では保存できないこと' do
        @purchase_shipping_add.postal_code = nil
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_shipping_add.postal_code = '1234567'
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include('Postal code is invalid')
      end
      it 'prefecture_idが1では保存できないこと' do
        @purchase_shipping_add.prefecture_id = 1
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'cityが空では保存できないこと' do
        @purchase_shipping_add.city = nil
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空では保存できないこと' do
        @purchase_shipping_add.addresses = nil
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空では保存できないこと' do
        @purchase_shipping_add.phone_number = nil
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it 'phone_numberが11桁未満では保存できないこと' do
        @purchase_shipping_add.phone_number = 1_234_567_890
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが12桁以上では保存できないこと' do
        @purchase_shipping_add.phone_number = 123_456_789_012
        @purchase_shipping_add.valid?
        expect(@purchase_shipping_add.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
