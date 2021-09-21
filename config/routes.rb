Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
  
  resources :account
  resources :screen
  resources :order
  resources :films do
    resources :screen do
      member do
        get :payment
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
