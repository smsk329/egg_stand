class Public::HomesController < ApplicationController

  def top
    shops = Shop.all.includes(:genres).order(created_at: :desc)
    @q = shops.ransack(params[:q])
    @shops = @q.result
    @shops = @shops.select{|o| o.genre_ids.include?(params[:genre_id].to_i) } if params[:genre_id].present?
  end

  def about
  end

end
