Rails.application.routes.draw do
  resources :work_references

  root to: 'users#index'
  devise_for :users
  resources :users
end
