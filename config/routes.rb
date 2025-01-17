Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/logout", to: "sessions#destroy"
    resources :users, only: :show
    resources :products, only: %i(index show)
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
