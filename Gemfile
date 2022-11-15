source 'https://rubygems.org'
ruby '3.1.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', '~> 2.1', '>= 2.1.1', groups: [:development, :test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0', '>= 7.0.4' # '~> 6.1.3.1', 6.0.4.1
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4', '>= 1.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'active_model_serializers', '~> 0.10.13'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  # gem 'factory_girl_rails', '~> 4.9'
  gem 'rspec-rails'
  # gem 'selenium-webdriver``'
end

group :development do
  gem 'derailed'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# OmniAuth Auth0 strategy and CSRF protection
gem 'omniauth-auth0', '~> 3.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'jwt'

# devise auth
# gem 'devise', '~> 4.7'
# gem 'devise_token_auth'
# gem 'omniauth'

gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'carrierwave', '~> 2.1'
gem 'carrierwave-base64'
gem 'mini_magick', '~> 4.8'
gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary', '~> 0.12.5'
gem 'wkhtmltopdf-binary', '~> 0.12.6.5'
gem "fog-aws"
gem 'aws-sdk', '~> 3'
gem 'combine_pdf'
gem 'pdfcrowd', '~> 4.4', '>= 4.4.2'
gem 'pdf-reader'

# pagination gem
gem 'kaminari', '~> 1.2.2'

gem 'rubyzip', '~> 2.3', '>= 2.3.2'
# gem 'administrate'
gem 'bourbon', '~> 7.2'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.7'
gem 'ransack', '~> 3.2', '>= 3.2.1'