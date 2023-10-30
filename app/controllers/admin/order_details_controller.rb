class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:order_id])
    if @order_detail.update(order_detail_params)
      @order.update(status: 2) if @order_detail.production_status == "making"
    elsif @order_detail.production_status == "done"
      if @order_detail.production_status[:done].count == @order_detail.count
        @order.update(status: 3) 
      end
      redirect_to request.referer
    else
      render 'orders/show'
    end
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
