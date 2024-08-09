Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pokemons#index"

  devise_scope :user do
    get "/app/login" => "devise/sessions#new"
  end

  devise_for :users, only: [:sessions, :registrations, :passwords]

  scope :app do
    resources :pokemons, only: [:index, :create], path: 'pokemon' do
      collection do
        get 'add', to: 'pokemons#new'
      end
    end
  end
end
