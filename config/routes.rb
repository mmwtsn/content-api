Rails.application.routes.draw do
  root 'welcome#index'

  resources :pages, shallow: true do
    member do
      get 'preview'
    end

    resources :scenarios, except: [:index]
    resources :resources, only: [:create, :edit, :update, :destroy]
  end

  #
  # TODO - How else to avoid deeply nested routes without re-generating
  #        these Scenarios resources? Passing an empty array to only
  #        ensures that no new resources are generated as we've already
  #        generated everything we need above (with pages/scenarios)
  #
  resources :scenarios, only: [] do
    resources :products, only: [:search, :create, :destroy]
  end

  post '/products/search', to: 'products#search', as: :products_search

  devise_for :users
end
