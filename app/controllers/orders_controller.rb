class OrdersController < ApplicationController
  def index
    @shipping = Item.find(params[:item_id])
    @order = Purchase.new
  end

  def new
    @order = PurchasesShippingAdd.new
  end

  def create
    # binding.pry
    @order = PurchasesShippingAdd.new(order_params)
    if @order.valid?
      @order.save
      render 'items/index'
    else
      render action: :new
    end
  end

  private

  def order_params
    params.require(purchase)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: item_id)
  end
end
