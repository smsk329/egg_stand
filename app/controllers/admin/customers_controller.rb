class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!
  before_action :ensure_normal_user, only: :edit

  def index
    @customers = Customer.all
  end

  def comment_edit
    @comment_all = Comment.all
    @comments = Comment.all.page(params[:page]).per(8)

  end

  def comment_destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
      redirect_to request.referer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end

  def ensure_normal_user
    @customer = Customer.find(params[:id])
    if @customer.email == 'guest@test.com'
      redirect_to admin_customers_path
    end
  end

end
