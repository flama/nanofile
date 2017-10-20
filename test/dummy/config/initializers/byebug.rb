if !Rails.env.production?
  require 'byebug/core'
  Byebug.start_server('0.0.0.0', 1048)
end
