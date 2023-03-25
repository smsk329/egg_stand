class Public::CommentsController < ApplicationController

  def create
    @shop = Shop.find(params[:shop_id])
    post_comment = current_customer.comments.new(comment_params)
    post_comment.shop_id = @shop.id
    post_comment.save
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.customer != current_customer
      redirect_to root_path
    else
      comment.destroy
    end
    @shop = Shop.find(params[:shop_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:post_comment)
  end
end
