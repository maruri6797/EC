class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    if @item.is_sell == false
      redirect_to items_path, notice: "この商品は売り切れです"
    end
    @cart_item = CartItem.new
  end
end
