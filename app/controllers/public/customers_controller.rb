class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "会員情報を編集しました。"
    else
      flash.now[:alert] = "会員情報を編集できませんでした。"
      render :edit
    end
  end
  
  def check
  end
  
  def leave
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会しました。ご利用ありがとうございました。"
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end
end
