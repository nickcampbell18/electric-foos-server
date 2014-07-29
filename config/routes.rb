require 'resque/server'

Rails.application.routes.draw do

  namespace :api do
    scope module: 'private' do

      resources :games, only: %i[show create update] do
        get :current, on: :collection
      end

      post   '/games/:game_id/goals/:team', to: 'goals#create'
      delete '/games/:game_id/goals/:team', to: 'goals#cancel'

      resources :players, only: :create

      resources :signatures, only: :create

    end

    namespace :public do
      resources :players, only: [:index, :show]
    end
  end

  mount Resque::Server, at: '/queue'

end
