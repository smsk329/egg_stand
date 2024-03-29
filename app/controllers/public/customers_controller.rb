class Public::CustomersController < ApplicationController

  before_action :is_matching_login_customer, only: [:edit, :update]
  before_action :authenticate_customer!, except: [:show]
  before_action :ensure_normal_user, only: :edit

  # マイページ(ログイン中のユーザーの情報、投稿一覧)
  def show
    @customer = current_customer
    @shops = @customer.shops.order(created_at: :desc)
  end

  # 他のユーザーの情報、投稿一覧
  def show_others
    @customer = Customer.find(params[:id])
    @shops = @customer.shops.order(created_at: :desc)
  end

  #  ログイン中のユーザーがいいねした投稿を表示
  def bookmark
    @customer = current_customer
    # ユーザーidが、このユーザがいいねしたレコードをすべて取得。shop_idも紐付ける。
    # pluckはテーブルの中からカラムの一覧をとってくる
    bookmark = Favorite.where(customer_id: @customer.id).pluck(:shop_id)
    @bookmarks = Shop.find(bookmark)
  end

  #  他のユーザーがいいねした投稿を表示
  def bookmark_others
    @customer = Customer.find(params[:id])
    bookmark = Favorite.where(customer_id: @customer.id).pluck(:shop_id)
    @bookmarks = Shop.find(bookmark)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_image, :name, :introduction)
  end

  def is_matching_login_customer
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id
      redirect_to root_path
    end
  end

  def ensure_normal_user
    @customer = Customer.find(params[:id])
    if @customer.email == 'guest@test.com'
      redirect_to customer_path(@customer.id)
      flash[:alert] = "ゲストユーザーは編集できません。"
    end
  end

end
