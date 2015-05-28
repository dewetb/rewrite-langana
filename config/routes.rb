Rails.application.routes.draw do

  root to: 'users#index'
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users do
    resources :work_references
    member do
      get :activate
    end
  end
end
