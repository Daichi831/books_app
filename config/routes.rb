# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  scope '(:locale)' do
    resources :books
    resources :users
  end
  get '/mypage' => 'users#mypage'
  get '/auth/:provider/callback' => 'sessions#create'
end
