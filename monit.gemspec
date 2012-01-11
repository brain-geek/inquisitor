$:.push File.expand_path("../lib", __FILE__)
require "monit/version"

Gem::Specification.new do |s|
  s.name        = "monit"
  s.version     = Monit::VERSION.dup
  s.description = "Service monitoring daemon with simple web UI."
  s.summary     = s.description
  s.author      = "Rozumiy Alexander"
  s.email       = "brain-geek@yandex.ua"
  s.homepage    = "https://github.com/brain-geek/monit"

  s.rubyforge_project = "outpost"

  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.files = `git ls-files -- {lib,spec}/*`.split("\n") + ["README.md", "LICENSE"]

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
