class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path, notice: "配送先を登録しました。"
    else
      flash.now[:alert] = "配送先を登録できませんでした。"
      @addresses = Address.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を編集しました。"
    else
      flash.now[:alert] = "配送先を編集できませんでした。"
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to request.referer, notice: "配送先を削除しました。"
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
