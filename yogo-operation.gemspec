Gem::Specification.new do |gem|
  gem.authors       = [ "Ryan Heimbuch" ]
  gem.email         = [ "yogo@msu.montana.edu" ]
  gem.description   = "yogo-operation contains extensions to Proc to support various higher-order operations"
  gem.summary       = "yogo-operation contains extensions to Proc to support various higher-order operations"
  gem.homepage      = "http://yogo.msu.montana.edu"
  gem.date          = "2011-12-20"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.rdoc]

  gem.name          = "yogo-operation"
  gem.require_paths = [ "lib" ]
  
  gem.version       = "0.2.1"


  gem.add_runtime_dependency("dataflow")
  gem.add_runtime_dependency("yogo-support")
end


