$:.push File.expand_path("../lib", __FILE__)
require "inquisitor/version"

Gem::Specification.new do |s|
  s.name        = "inquisitor"
  s.version     = Inquisitor::VERSION.dup
  s.description = "Monitoring daemon with simple web UI."
  s.summary     = s.description
  s.author      = "Rozumiy Alexander"
  s.email       = "brain-geek@yandex.ua"
  s.homepage    = "https://github.com/brain-geek/inquisitor"

  s.test_files    = Dir.glob("spec/**/*")
  s.executables   = Dir.glob("bin/**/*").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.files = Dir.glob("{lib,bin}/**/*") + ["README.md", "LICENSE"]

  s.add_dependency 'data_mapper'

  s.add_dependency 'outpost'
  s.add_dependency 'net-ping'
  s.add_dependency 'mail'

  s.add_dependency "sinatra"
  s.add_dependency 'sinatra-contrib'
  s.add_dependency 'haml'
  s.add_dependency 'emk-sinatra-url-for'

  s.add_dependency 'slop'
end