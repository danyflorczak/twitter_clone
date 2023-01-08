source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem 'devise', '~> 4.8', '>= 4.8.1'
gem "jbuilder"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "pundit", "~> 2.2"
gem "rails", "~> 7.0.4"
gem "redis", "~> 4.0"
gem "sassc-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails", "~> 6.0.0"
end

group :development do
  gem "rubocop", "~> 1.36", require: false
  gem "rubocop-performance", require: false
  gem "web-console"
end

group :test do 
  gem "shoulda-matchers", "~> 5.0"
end

