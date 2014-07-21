require 'resque/server'

Rails.application.routes.draw do

  namespace :api do
    resources :games, only: %i[show create] do
      resources :goals, only: %i[create]
    end
  end

  post 'push-hook', to: 'pusher#receive'

  mount Resque::Server, at: '/queue'

end
