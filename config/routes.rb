Rails.application.routes.draw do

  resources :frame, only: [:index]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: "users/interactions#index"

  namespace :users do
    resources :interactions, only: [:index, :show, :create]
    resources :services, only: [:index]
    resources :referrals, only: [:new, :create]
  end
end
