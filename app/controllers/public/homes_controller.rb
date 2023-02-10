class Public::HomesController < ApplicationController

  def top
    @shops = Shop.all.order("created_at DESC")
  end

  def about
  end
end
