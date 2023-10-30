class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10).order(created_at: :asc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: '商品を登録しました。'
    else
      flash.now[:alert] = '登録に失敗しました。'
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: '商品を編集しました。'
    else
      flash.now[:alert] = '編集に失敗しました。'
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :is_sell, :genre_id, :image)
  end
end
