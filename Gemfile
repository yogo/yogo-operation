source :rubygems
gemspec

#
# Development and Test Dependencies
#
group :development, :test do
  gem "rake"
  gem "jeweler"
  gem "yard"
  gem "yardstick"
  # Testing gems
  gem "rspec"
  gem "rack-test"
  gem "cucumber"

  platforms(:mri_19) do
    gem "ruby-debug19",       :require => "ruby-debug"
    gem "rack-debug19",       :require => "rack-debug"
  end

  platforms(:mri_18) do
    gem "ruby-debug"
    gem "rack-debug"
  end
end