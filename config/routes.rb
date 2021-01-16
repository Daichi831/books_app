# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  scope '(:locale)' do
    resources :books
    resources :users
  end
  get '/mypage' => 'users#mypage'
  resources :users do
    member do
      get :followees, :followers
    end
  end
  resources :freindships, only: %i[create destroy]
end
