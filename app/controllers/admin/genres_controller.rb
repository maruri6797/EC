class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to request.referer, notice: 'ジャンルを追加しました。'
    else
      @genres = Genre.all
      flash.now[:alert] = 'ジャンルを追加できませんでした。'
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'ジャンルを編集しました。'
    else
      flash.now[:alert] = 'ジャンルを編集できませんでした。'
      render :edit
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
