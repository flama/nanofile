module Nanofile
  class Engine < ::Rails::Engine
    isolate_namespace Nanofile

    config.to_prepare do
      ApplicationController.helper(Nanofile::Engine.helpers)
    end
  end
end
