Gem::Specification.new do |s|
  s.require_paths = ['lib']
  s.name          = 'MehPlayer'
  s.version       = '0.1.0'
  s.description   = "Music player with skins"
  s.authors       = ["Diana Geneva"]
  s.summary       = "Simple player"
  s.email         = 'dageneva@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.homepage      =
    'https://github.com/bitterfly/MehPlayer'
  s.license       = 'GPLv3'
  s.executables   = ["mehplayer-gui", "mehplayer-cli"]
  s.add_runtime_dependency 'rubygame', '~> 2'
  s.add_runtime_dependency 'taglib-ruby', '~> 0'
  s.add_runtime_dependency 'qtbindings', '~> 4'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop', '~> 0'
  s.add_development_dependency 'fakefs', '~> 0'
end
