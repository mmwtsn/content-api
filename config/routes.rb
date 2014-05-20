Rails.application.routes.draw do
  root 'welcome#index'

  # Temporary hack around our hackity-hack rendering
  # TODO - set up proper slug-based routing
  get '/cloud-computing/us/en/solutions-gaming.html', to: 'pages#show', id: 1

  resources :pages

  devise_for :users
end
