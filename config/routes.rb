# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show' => 'users#show'
  get '/mypage' => 'users#mypage'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: %i[show edit update]
  scope '(:locale)' do
    resources :books
  end
  root to: 'books#index'
end
