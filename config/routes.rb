Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    devise_for :users, controllers: {sessions: "sessions"}
    as :user do
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      get "/logout", to: "sessions#destroy"
    end

    get "/home", to: "static_pages#home"
    resources :users, only: :show
    resources :products, only: %i(index show) do
      collection do
        match "search" => "products#index", via: [:get, :post], as: :search
      end
    end
    resources :carts, only: %i(create index destroy) do
      collection do
        get "reset"
      end
    end
    resources :orders
    namespace :admin do
      root "static_pages#home"
      resources :products, only: :index
      resources :orders, only: [:index, :update] do
        resources :order_details, only: :index
      end
    end
    resources :orders, only: %i(new create)
  end
end
