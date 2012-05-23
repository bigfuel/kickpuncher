require 'sidekiq/web'

Kickpuncher::Application.routes.draw do
  root to: 'projects#index'

  resources :projects, only: [:index, :show, :create, :update, :destroy] do
    put 'activate', on: :member
    put 'deactivate', on: :member
  end

  resources :permissions, only: [:index, :show, :create, :update, :destroy]

  resources :signups, only: [:index, :show, :create, :update, :destroy]

  resources :events, only: [:index, :show, :create, :update, :destroy] do
    put 'approve', on: :member
    put 'deny', on: :member
    post 'import', on: :collection
  end

  resources :videos, only: [:index, :show, :create, :update, :destroy] do
    put 'approve', on: :member
    put 'deny', on: :member
  end

  resources :images, only: [:index, :show, :create, :update, :destroy] do
    put 'approve', on: :member
    put 'deny', on: :member
  end

  resources :feeds, only: [:index, :show, :create, :update, :destroy]

  resources :posts, only: [:index, :show, :create, :update, :destroy] do
    put 'approve', on: :member
    put 'deny', on: :member
  end

  resources :facebook_albums, only: [:index, :show, :create, :update, :destroy]

  resources :facebook_events, only: [:index, :show, :create, :update, :destroy]

  resources :submissions, only: [:index, :show, :create, :update, :destroy] do
    put 'approve', on: :member
    put 'deny', on: :member
  end

  resources :polls, only: [:index, :show, :create, :update, :destroy] do
    put 'activate', on: :member
    put 'deactivate', on: :member
    put 'vote', on: :member
  end

  mount Sidekiq::Web => '/sidekiq'
end
