source :rubygems
gemspec

#
# Development and Test Dependencies
#
group :development, :test do
  platforms(:mri_19) do
    gem "ruby-debug19",       :require => "ruby-debug"
    gem "rack-debug19",       :require => "rack-debug"
  end

  platforms(:mri_18) do
    gem "ruby-debug"
    gem "rack-debug"
  end
end

group :development do
  gem "rake"
  gem "jeweler"
  gem "yard"
  gem "yardstick"
end

group :test do
  gem "rspec"
  gem "rack-test"
  gem "cucumber"
end
