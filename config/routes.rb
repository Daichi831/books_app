# frozen_string_literal: true

Rails.application.routes.draw do
  get '/mypage' => 'users#mypage'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: %i[show edit update]
  scope '(:locale)' do
    resources :books, :users
  end
  root to: 'books#index'
end
