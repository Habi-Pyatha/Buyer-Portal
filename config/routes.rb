Rails.application.routes.draw do
  devise_for :users

  get "dashboard", to: "dashboard#index"
  resources :properties, only: [ :index, :show ] do
    member do
      post "favourite"
      delete "favourite"
    end
  end

  root "properties#index"
end
