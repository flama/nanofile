Rails.application.routes.draw do
  resources :profiles
  mount Nanofile::Engine => "/nanofile"

  # remember to mount it inside your authorization boundries
  mount Nanofile::ImageUploader.presign_endpoint(:cache) => '/nanofile/presign', as: :nanofile_presign

  post '/nanofile/promote' => 'uploads#create', as: :nanofile_promote
  get '/nanofile/show/:id' => 'uploads#show', as: :nanofile_image

  get '/:page' => 'pages#show', as: :page
  root to: 'profiles#index'
end
