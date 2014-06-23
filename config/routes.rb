Rails.application.routes.draw do
  root 'welcome#index'

  # Temporary hack around our hackity-hack rendering
  # TODO - set up proper slug-based routing
  get '/cloud-computing/us/en/solutions-gaming.html', to: 'pages#show', id: 1

  resources :pages, shallow: true do
    resources :scenarios

    resources :resources, shallow: true
  end

  resources :scenarios do
    resources :products
  end

  post '/products/search', to: 'products#search', as: :products_search

  devise_for :users
end
