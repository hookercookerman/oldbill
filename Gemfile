source "http://rubygems.org"

gemspec

# Will automatically pull in this gem and all its
# dependencies specified in the gemspec
gem "oldbill", :path => File.expand_path("..", __FILE__)
gem "yard"

# These are development dependencies 
group :test do
  gem "rake"
  gem "rspec", "2.5.0"
  gem 'vcr',                '~> 1.5', :require => false
  gem 'webmock',            '~> 1.6', :require => false
  gem "autotest"
end

