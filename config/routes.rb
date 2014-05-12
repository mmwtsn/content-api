Rails.application.routes.draw do
  root 'welcome#index'

  resource :pages

  devise_for :users
end
