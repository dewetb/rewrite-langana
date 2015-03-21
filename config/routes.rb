Rails.application.routes.draw do
  resources :references

  root to: 'users#index'
  devise_for :users
  resources :users
end
