class ItemsController < ApplicationController
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if current_user.id != @item.user.id
      redirect_to root_path
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path(item)
    else
      render edit_item_path
    end
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
