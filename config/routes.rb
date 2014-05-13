Rails.application.routes.draw do
  root 'welcome#index'

  resources :pages

  devise_for :users
end
