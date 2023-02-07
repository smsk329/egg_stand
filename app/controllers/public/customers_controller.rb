class Public::CustomersController < ApplicationController

  # マイページ
  def show
    @customer = Customer.find(params[:id])
    @shops = @customer.shops
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
      redirect_to customer_path(customer.id)
  end

  # いいね一覧画面
  def bookmark
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
