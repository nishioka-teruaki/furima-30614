class OrdersController < ApplicationController

  def index
  end

  def new
    @order = PurchasesShippingAdd.new
  end

  def create
    @order = PurchasesShippingAdd.create(order_params)
    if @order.save
      render "items/index"
    else
      render action: :new
    end
  end

  private

  def order_params
    params.require(:PurchasesShippingAdd).
           permit(:item, :user, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :purchase).
           merge(user_id: current_user.id, item_id: current_user.id)
  end

end
