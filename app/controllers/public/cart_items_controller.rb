class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def create
    current_cart = CartItem.where(customer_id: current_customer.id)
    current_cart_item = current_cart.find_by(item_id: cart_item_params[:item_id])
    if current_cart.present? && current_cart_item.present?
      current_cart_item.amount += cart_item_params[:amount].to_i
      current_cart_item.save
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartITem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    cart_items = current_customer.cart_items.all
    cart_items.destroy_all
    redirect_to request.referer
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
