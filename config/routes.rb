# frozen_string_literal: true

Rails.application.routes.draw do
  get '/mypage' => 'users#mypage'
  get '/auth/:provider/callback' => 'sessions#create'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  scope '(:locale)' do
    resources :books
    resources :users, only: %i[index edit update destroy]
  end
  root to: 'books#index'
end
