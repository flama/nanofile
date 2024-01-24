$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'nanofile/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'nanofile'
  s.version     = Nanofile::VERSION
  s.authors     = ['Flama Team']
  s.email       = ['hello@flama.is']
  s.homepage    = 'https://flama.is'
  s.summary     = 'Adaptable file uploader for CMS creators.'
  s.description = 'Simple yet powerful file uploader for people who build their own CMS.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.0'

  # Image processing
  s.add_dependency 'image_processing', '~> 0.4.4'
  s.add_dependency 'mini_magick', '>= 4.3.5'

  # Image dimensions
  s.add_dependency 'fastimage', '~> 2.1'

  # Optimize image
  s.add_dependency 'image_optim', '~> 0.25.0'
  s.add_dependency 'image_optim_pack', '~> 0.5.0.20170831'

  # Shrine
  s.add_dependency 'roda', '~> 2.29.0'
  s.add_dependency 'aws-sdk-s3', '~> 1.5'
  s.add_dependency 'shrine', '~> 2.8'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'webpacker', '~> 3.0', '3.0.1'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'sass-rails', '~> 5.0', '>= 5.0.6'
end
