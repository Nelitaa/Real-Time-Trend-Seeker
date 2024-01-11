Rails.application.routes.draw do
  root 'articles#index'

  resources :articles

  get '/search', to: 'searches#index', as: :search
end
