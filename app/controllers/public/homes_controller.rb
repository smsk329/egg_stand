class Public::HomesController < ApplicationController

  def top
    @q = Shop.ransack(params[:q])
    @shop = @q.result
  end

  def about
  end

end
