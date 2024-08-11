# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Mount the MissionControl::Jobs engine at /jobs
  mount MissionControl::Jobs::Engine, at: '/jobs'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pokemons#index'

  devise_scope :user do
    get '/app/login' => 'devise/sessions#new'
  end

  devise_for :users, only: %i[sessions registrations passwords]

  scope :app do
    resources :pokemons, only: %i[index show create edit update destroy], path: 'pokemon' do
      collection do
        get 'add', to: 'pokemons#new'
      end
    end

    resources :trainers, only: %i[index show create edit update destroy], path: 'trainer' do
      collection do
        get 'add', to: 'trainers#new'
      end
    end

    resources :user_pokemons, only: %i[new create]
  end
end
