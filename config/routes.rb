Rails.application.routes.draw do

  namespace :api do
    resources :games, only: :create
  end

end
