require 'sidekiq/web'

Kickpuncher::Application.routes.draw do
  root to: 'projects#show'

  resources :projects do
    member do
      match '/index' => 'projects#show'
    end
  end

  resources :project
  resources :signups
  resources :events
  resources :videos
  resources :images
  resources :feeds
  resources :posts
  resources :facebook_albums
  resources :facebook_events

  resources :polls do
    put 'vote', on: :member
  end

  resources :submissions do
    post 'submit', on: :member
  end

  mount Sidekiq::Web => '/sidekiq'
end
