Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: "users/interactions#index"

  resources :referrals, only: [:index] do
    collection do
      post 'mark'
      get 'confirmed'
    end
  end

  namespace :users do
    resources :interactions, only: [:index, :show, :new, :create] do
      scope module: 'interactions' do
        resources :events, only: [:create]
      end
    end

    resources :clients, only: [:edit, :update, :index, :new, :create]
    resources :services, only: [:index]
    resources :referrals, only: [:new, :create, :show, :update]
  end
end
