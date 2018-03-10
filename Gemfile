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
end
