begin
  require 'bundler'
  Bundler.setup
rescue LoadError
  puts "Bundler is not intalled. Install with: gem install bundler"
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name =          %q{yogo-operation}
  gem.authors =       ["Ryan Heimbuch"]
  gem.date =          %q{2010-09-16}
  gem.description =   %q{yogo-operation contains extensions to Proc to support various higher-order operations}
  gem.email =         %q{rheimbuch@gmail.com}
  gem.homepage =      %q{http://github.com/yogo/yogo-operation}
  gem.rdoc_options =  ["--charset=UTF-8"]
  gem.summary =       %q{specialization of Proc}
  gem.add_dependency( %q<dataflow>,     ">= 0"    )
  gem.add_dependency( %q<yogo-support>, "~> 0.1.0")
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Run all examples using rcov'
  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.rcov = true
    spec.rcov_opts =  %[-Ilib -Ispec --exclude "mocks,expectations,gems/*,spec/resources,spec/lib,spec/spec_helper.rb,db/*,/Library/Ruby/*,config/*"]
    spec.rcov_opts << %[--no-html --aggregate coverage.data]
  end
rescue LoadError
  puts "RSpec not installed. Install with: bundle install"
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
