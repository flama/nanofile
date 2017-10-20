Rails.application.routes.draw do
  mount Nanofile::Engine => "/nanofile"
end
