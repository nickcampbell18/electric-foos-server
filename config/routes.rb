require 'resque/server'

Rails.application.routes.draw do

  namespace :api do

    resources :games, only: %i[show create update] do
      post '/goals/:team', on: :member,
                           to: 'goals#create'
    end

    resources :goals, only: :create

    resources :players, only: :create

    resources :signatures, only: :create # Ask Ray to POST

    get '/stream', to: 'streams#stream'
  end

  get '/', to: 'web#index'

  post 'push-hook', to: 'pusher#receive'

  mount Resque::Server, at: '/queue'

end
