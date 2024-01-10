Rails.application.routes.draw do
  resources :searches, only: [:index]
  resources :articles

  root "searches#home"
end
