Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    
    root to: 'homes#top'
    get 'homes/about' => "homes#about", as: "about"
    
    get 'customers/withdrawal_check' => "customers#withdrawal_check", as: "withdrawal_check"
    get 'customers/information/edit' => "customers#edit", as: "edit"
    patch 'customers/information' => "customers#update", as: "update"
    resources :customers, only: [:show, :edit, :update]
    
    resources :shops, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  namespace :admin do
    
    get 'homes/top' => "homes#top", as: "top"
    
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :genre_relations, only: [:destroy]
    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
