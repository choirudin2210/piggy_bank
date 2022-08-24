Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations'}
  resources :stocks
  resources :teams
  resources :wallets do
    resources :transfers, module: :wallets, only:[:index, :create]
  end
  resources :transfers, only:[:index, :create]
  resources :transactions
  root 'homes#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
