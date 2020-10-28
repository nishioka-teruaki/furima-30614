class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path(@item)
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if current_user.id != @item.user.id
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :info,
                                 :category_id,
                                 :sales_status_id,
                                 :shipping_fee_status_id,
                                 :item_prefecture_id,
                                 :scheduled_delivery_id,
                                 :price, :image).merge(user_id: current_user.id)
  end
end
