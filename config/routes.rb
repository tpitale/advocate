Rails.application.routes.draw do
  root to: "users/interactions#index"

  namespace :users do
    resources :interactions, only: [:index, :show, :create]
    resources :services, only: [:index]
    resources :referrals, only: [:new, :create]
  end
end
