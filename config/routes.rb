Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
  
  resources :account
  resources :user
  resources :screen
  resources :order do
    collection do
      post :sent_you_ticket
      post :cancel_order
    end
  end
  resources :films do
    resources :ticket_order
    resources :screen do
      member do
        get :payment
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
