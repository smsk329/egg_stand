class Public::ShopsController < ApplicationController

  def new
    @shop = Shop.new
  end

  def create
    shop = Shop.new(shop_params)
    shop.customer_id = current_customer.id
    shop.save
      redirect_to root_path
  end

  def index
    @shops = Shop.all
    # 投稿一覧はtopページに表示するため今のところ不要
  end

  def show
    @shop = Shop.find(params[:id])
    @customer = @shop.customer
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    shop = Shop.find(params[:id])
    shop.update(shop_params)
      redirect_to shop_path(shop.id)
  end

  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
      redirect_to root_path
  end

  private

  def shop_params
    params.require(:shop).permit(:customer_id, :shop_image, :title, :body, :open_time, :close_time, :address, :price, :holiday, :mood, :wifi, :charging, :cashless)
  end

end
