Rails.application.routes.draw do
  resources :profiles
  mount Nanofile::Engine => "/nanofile"
end
