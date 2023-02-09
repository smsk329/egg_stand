class Public::CustomersController < ApplicationController

  # マイページ(ログイン中のユーザーの情報、投稿一覧)
  def show
    @customer = current_customer
    @shops = @customer.shops
  end

  # 他のユーザーの情報、投稿一覧
  def show_others
    @customer = Customer.find(params[:id])
    @shops = @customer.shops
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
    # ユーザーidが、このユーザがいいねしたレコードをすべて取得。shop_idも紐付ける。
   # pluckはテーブルの中からカラムの一覧をとってくる
    bookmark = Favorite.where(customer_id: @customer.id).pluck(:shop_id)
    @bookmarks = Shop.find(bookmark)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
      redirect_to customer_path(customer.id)
  end

  # 退会確認画面
  def withdrawal_check
  end

  # 退会処理
  def withdrawal
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_image, :name, :introduction)
  end

end
