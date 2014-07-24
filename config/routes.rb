require 'resque/server'

Rails.application.routes.draw do

  namespace :api do
    resources :games, only: %i[show create] do
      resources :goals, only: %i[create]
    end

    resources :players, only: :create

    resources :signatures, only: %i[show create] # Ask Ray to POST

    get '/stream', to: 'streams#stream'
  end

  post 'push-hook', to: 'pusher#receive'

  mount Resque::Server, at: '/queue'

end
