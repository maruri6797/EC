class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end
  
  def create
    @address = Address.new
    if @address.save(genre_params)
      redirect_to request.referer, notice: "配送先を登録しました。"
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
    if @address.update(genre_params)
      redirect_to public_genres_path, notice: "配送先を編集しました。"
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
