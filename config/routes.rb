Rails.application.routes.draw do
  get 'orders/index'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: :show
    namespace :admin do
      root "static_pages#home"
      resources :orders, only: :index
    end
  end
end
