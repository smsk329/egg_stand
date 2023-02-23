class Public::HomesController < ApplicationController

  def top
    shops = Shop.all.includes(:genres).order(created_at: :desc)
    @q = shops.ransack(params[:q])
    # ジャンル検索をする場合
    if params[:genre_id].present?
      shop_list = shops.select{|o| o.genre_ids.include?(params[:genre_id].to_i) }
      # selectを使うとarray（配列）になるためページネーションが使えない。mapでactiv recordを取得する。
      shop_ids = shop_list.map do |shop|
        shop.id
      end
      # 検索結果の絞り込みをする前に、件数表示のための変数を用意する
      @shop_count = Shop.where(id: shop_ids).count
      # activ recordで検索結果を表示する
      @shops = Shop.where(id: shop_ids).page(params[:page]).per(6)

    #キーワード検索をする場合
    else
      # 検索結果の絞り込みをする前に、件数表示のための変数を用意する
      @shop_count = @q.result.count
      # 検索結果を表示する
      @shops = @q.result.page(params[:page]).per(6).order('created_at DESC')
    end
  end

  def about
  end

end
