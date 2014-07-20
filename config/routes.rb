require 'resque/server'

Rails.application.routes.draw do

  namespace :api do
    resources :games, only: %i[show create] do
      resources :goals, only: %i[create]
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  mount Resque::Server, at: '/queue'

end
