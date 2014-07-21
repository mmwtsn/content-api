Rails.application.routes.draw do
  root 'welcome#index'

  resources :pages, shallow: true do
    member do
      get 'preview'
    end

    resources :scenarios
    resources :resources, shallow: true
  end

  resources :scenarios do
    resources :products
  end

  post '/products/search', to: 'products#search', as: :products_search

  devise_for :users
end
