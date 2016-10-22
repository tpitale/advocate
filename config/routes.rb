Rails.application.routes.draw do
  namespace :users do
    resources :interactions, only: [:index, :show, :create]
    resources :services, only: [:index]
    resources :referrals, only: [:new, :create]
  end
end
