Rails.application.routes.draw do
  resources :profiles
  resources :photos

  root to: 'profiles#index'
end
