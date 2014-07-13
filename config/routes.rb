Rails.application.routes.draw do

  namespace :api do
    resources :games, only: :create
    resources :goals, only: :create
  end

end
