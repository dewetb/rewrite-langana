Rails.application.routes.draw do

  root to: 'users#index'
  devise_for :users, controllers: {
        sessions: 'sessions'
      }
  resources :users do
    resources :work_references
    member do
      get :activate
    end
  end
end
