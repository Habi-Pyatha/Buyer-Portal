Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :properties
  end

  get "dashboard", to: "dashboard#index"
  resources :properties, only: [ :index, :show ] do
    member do
      post "favourite"
      delete "favourite"
    end
  end

  root "properties#index"
end
