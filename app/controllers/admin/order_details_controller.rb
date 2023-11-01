class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details

    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(status: 2) if @order_detail.production_status == "making"
      @order_details.each do |order_detail|
        if order_detail.production_status != "done"
          is_updated = false
        end
      end
      @order.update(status: 3) if is_updated
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
