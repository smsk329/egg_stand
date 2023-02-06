class Public::HomesController < ApplicationController
  def top
    @shops = Shop.all
  end

  def about
  end
end
