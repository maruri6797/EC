class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    cart_items = current_customer.cart_items
    if @order.save
      cart_items.each do |cart_item|
        order_details = OrderDetail.new
        order_details.item_id = cart_item.item.id
        order_details.order_id = @order.id
        order_details.purchase_price = cart_item.item.with_tax_price
        order_details.amount = cart_item.amount
        order_details.save
      end
      current_customer.cart_items.destroy_all
      redirect_to confirm_orders_path
    else
      flash.now[:alert] = "注文が確定できませんでした。もう一度やり直してください。"
      render :new
    end
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    end
  end
  
  def complete
  end
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_price)
  end
end
