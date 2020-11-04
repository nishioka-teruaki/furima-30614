class OrdersController < ApplicationController
  def index
    if user_signed_in?
      @shipping = Item.find(params[:item_id])
      redirect_to root_path if current_user.id == @shipping.user_id || !@shipping.purchase.nil?
      @order = PurchasesShippingAdd.new
    else
      redirect_to user_session
    end
  end

  def create
    @order = PurchasesShippingAdd.new(order_params)
    shipping = Item.find(params[:item_id])
    @price = shipping.price
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      @shipping = Item.find(params[:item_id])
      render action: :index
    end
  end

  private

  def order_params
    params.require(:purchases_shipping_add)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @price,
      card: order_params[:token],
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
