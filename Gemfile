source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

gem 'rails', '~> 5.1.5'

gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'turbolinks'

group :development, :test do
  gem 'pry-rails'
end

group :development do
  gem 'spring'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'site_prism'
  gem 'webmock'
end
