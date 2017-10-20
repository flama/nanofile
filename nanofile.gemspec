$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nanofile/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nanofile"
  s.version     = Nanofile::VERSION
  s.authors     = ["Flama Team"]
  s.email       = [""]
  s.homepage    = "https://flama.is"
  s.summary     = "An adatable file uploader for CMS creators."
  s.description = "Simple yet powerful file uploader for people who build their own CMS."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency 'byebug', '~> 9.1'
  s.add_development_dependency "sqlite3"
end
