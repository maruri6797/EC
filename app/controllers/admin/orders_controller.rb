class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
    if @order.update(order_params)
      @order_detail.update_all(production_status: 1) if @order.status == "paid_up"
      redirect_to request.referer
    else
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
