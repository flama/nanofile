Nanofile::Engine.routes.draw do
  mount Shrine.presign_endpoint(:cache) => '/presign', as: :presign
end
