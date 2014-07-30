require 'resque/server'

Rails.application.routes.draw do

  namespace :api do

    get '/games/current', to: 'public/games#current'

    scope module: 'private' do

      resources :games, only: %i[show create update]

      post   '/games/:game_id/goals/:team', to: 'goals#create'
      delete '/games/:game_id/goals/:team', to: 'goals#cancel'

      resources :players, only: :create

      resources :signatures, only: :create

    end

    namespace :public do
      resources :players, only: [:index, :show]
      resources :games,   only: [:index, :show]
      resources :stats,   only: :index
    end
  end

  mount Resque::Server, at: '/api/queue'

end
