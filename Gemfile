# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers', '~> 0.10.13'
gem 'coffee-rails', '~> 5.0'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1', groups: %i[development test]
gem 'jbuilder', '~> 2.6'
gem 'pg', '~> 1.4', '>= 1.4.4'
gem 'puma', '~> 4.3'
gem 'rails', '~> 7.0', '>= 7.0.4' # '~> 6.1.3.1', 6.0.4.1
gem 'rubocop', '~> 1.39'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'standard'
  # gem 'factory_girl_rails', '~> 4.9'
  # gem 'selenium-webdriver``'
end

group :development do
  gem 'derailed'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'aws-sdk', '~> 3'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'bourbon', '~> 7.2'
gem 'carrierwave', '~> 2.1'
gem 'carrierwave-base64'
gem 'combine_pdf'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.7'
gem 'fog-aws'
gem 'jwt'
gem 'kaminari', '~> 1.2.2' # pagination gem
gem 'mini_magick', '~> 4.8'
gem 'omniauth-auth0', '~> 3.0' # OmniAuth Auth0 strategy and CSRF protection
gem 'omniauth-rails_csrf_protection', '~> 1.0' # OmniAuth Auth0 strategy and CSRF protection
gem 'pdfcrowd', '~> 4.4', '>= 4.4.2'
gem 'pdf-reader'
gem 'ransack', '~> 3.2', '>= 3.2.1'
gem 'rubyzip', '~> 2.3', '>= 2.3.2'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary', '~> 0.12.6.5'

# gem 'redis', '~> 3.0' # Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment
# gem 'administrate'
# gem 'wkhtmltopdf-binary', '~> 0.12.5'
# gem 'devise', '~> 4.7' # devise auth
# gem 'devise_token_auth' # devise auth
# gem 'omniauth' # devise auth
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
