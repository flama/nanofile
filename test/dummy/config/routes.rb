Rails.application.routes.draw do
  resources :profiles
  mount Nanofile::Engine => "/nanofile"

  post '/uploads/promote' => 'uploads#create'
  get '/uploads/show/:id' => 'uploads#show'

  get '/:page' => 'pages#show', as: :page
  root to: 'profiles#index'
end
