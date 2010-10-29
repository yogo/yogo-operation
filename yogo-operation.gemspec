# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yogo-operation}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Heimbuch"]
  s.date = %q{2010-10-28}
  s.description = %q{yogo-operation contains extensions to Proc to support various higher-order operations}
  s.email = %q{rheimbuch@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "features/step_definitions/yogo-operation_steps.rb",
     "features/support/env.rb",
     "features/yogo-operation.feature",
     "lib/yogo/operation.rb",
     "lib/yogo/operation/base.rb",
     "lib/yogo/operation/closed.rb",
     "lib/yogo/operation/closed/call.rb",
     "lib/yogo/operation/closed/error.rb",
     "lib/yogo/operation/concurrent.rb",
     "lib/yogo/operation/concurrent/call.rb",
     "lib/yogo/operation/error.rb",
     "lib/yogo/operation/restricted.rb",
     "lib/yogo/operation/restricted/call.rb",
     "lib/yogo/operation/restricted/compose.rb",
     "lib/yogo/operation/restricted/construction.rb",
     "lib/yogo/operation/restricted/error.rb",
     "lib/yogo/operation/restricted/expected_type.rb",
     "lib/yogo/operation/restricted/partial.rb",
     "spec/spec_helper.rb",
     "spec/yogo-operation_spec.rb",
     "yogo-operation.gemspec"
  ]
  s.homepage = %q{http://github.com/yogo/yogo-operation}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{specialization of Proc}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/yogo-operation_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dataflow>, [">= 0"])
      s.add_runtime_dependency(%q<yogo-support>, ["~> 0.1.0"])
    else
      s.add_dependency(%q<dataflow>, [">= 0"])
      s.add_dependency(%q<yogo-support>, ["~> 0.1.0"])
    end
  else
    s.add_dependency(%q<dataflow>, [">= 0"])
    s.add_dependency(%q<yogo-support>, ["~> 0.1.0"])
  end
end

