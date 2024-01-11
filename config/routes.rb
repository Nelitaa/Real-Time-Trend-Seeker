Rails.application.routes.draw do
  resources :searches, only: [:index]
  resources :articles, only: [:index]

  root "searches#home"
end
