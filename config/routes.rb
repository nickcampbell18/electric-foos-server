require 'resque/server'

Rails.application.routes.draw do

  namespace :api do

    resources :games, only: %i[show create update]

    post '/games/:game_id/goals/:team', to: 'goals#create'

    resources :players, only: :create

    resources :signatures, only: :create # Ask Ray to POST

    get '/stream', to: 'streams#stream'
  end

  get '/', to: 'web#index'

  mount Resque::Server, at: '/queue'

end
