class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: '会員情報を編集しました。'
    else
      flash.now[:alert] = '会員情報の編集ができませんでした。'
      render :edit
    end
  end

  def order
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.order(created_at: desc).page(params[:page]).per(10)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end
end