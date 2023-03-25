Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# ゲスト用
  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do

    root to: 'homes#top'
    get 'homes/about' => "homes#about", as: "about"

    get 'customers/withdrawal_check' => "customers#withdrawal_check", as: "withdrawal_check"
    patch 'customers/withdrawal' => "customers#withdrawal", as: "withdrawal"
    resources :customers, only: [:show, :edit, :update]do
      member do
        # URLにIDを含める場合のオリジナルアクションのルーティング
        get :bookmark
        get :bookmark_others
        get :show_others
      end
    end

    resources :shops, only: [:show, :new, :create, :edit, :update, :destroy]do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  namespace :admin do

    get 'homes/top' => "homes#top", as: "top"

    get 'customers/comment_edit' => "customers#comment_edit", as: "comment_edit"
    delete 'customers/comment_destroy/:id' => "customers#comment_destroy", as: "comment_destroy"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
    # 不要と思われる
    resources :genre_relations, only: [:destroy]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
