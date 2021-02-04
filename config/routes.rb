Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :new, :create, :show]
      resources :surveys, only: [:index, :new, :create, :show, :destroy] do
        resources :choices, only: [:new, :create]
        resources :responses, only: [:new, :create, :show] do
          resources :rankings, only: [:new, :create]
        end
      end
      resources :responses, only: [:new, :create, :destroy] do
        resources :rankings, only: [:new, :create]
      end
      resources :rankings, only: [:update]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
