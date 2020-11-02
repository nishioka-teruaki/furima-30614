class OrdersController < ApplicationController
  def index
    @shipping = Item.find(params[:item_id])
    @order = PurchasesShippingAdd.new
  end

  # def new
  #   @order = PurchasesShippingAdd.new
  # end

  def create
    binding.pry
    @order = PurchasesShippingAdd.new(order_params)
    if @order.valid?
      @order.save
      render 'items/index'
    else
      @shipping = Item.find(params[:item_id])
      render action: :index
    end
  end

  private

  def order_params
    params.require(:purchases_shipping_add)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
