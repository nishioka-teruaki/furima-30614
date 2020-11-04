class OrdersController < ApplicationController
  before_action :set_shipping, only: [:index, :create]

  def index
    if user_signed_in?
      redirect_to root_path if current_user.id == @shipping.user_id || !@shipping.purchase.nil?
      @order = PurchasesShippingAdd.new
    else
      redirect_to user_session_path
    end
  end

  def create
    @order = PurchasesShippingAdd.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  def set_shipping
    @shipping = Item.find(params[:item_id])
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
      amount: @shipping.price,
      card: order_params[:token],
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
