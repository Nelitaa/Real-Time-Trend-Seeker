Rails.application.routes.draw do
  root 'searches#home'

  get '/searches', to: 'searches#index', as: :searches

  resources :articles
end
