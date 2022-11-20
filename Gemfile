source 'https://rubygems.org'
ruby '2.7.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', '~> 2.1', '>= 2.1.1', groups: [:development, :test]
gem 'rails', '~> 7.0', '>= 7.0.4' # '~> 6.1.3.1', 6.0.4.1
gem 'pg', '~> 1.4', '>= 1.4.4'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.6'
gem 'active_model_serializers', '~> 0.10.13'
gem 'rubocop', '~> 1.39'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  # gem 'factory_girl_rails', '~> 4.9'
  # gem 'selenium-webdriver``'
end

group :development do
  gem 'derailed'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'omniauth-auth0', '~> 3.0' # OmniAuth Auth0 strategy and CSRF protection
gem 'omniauth-rails_csrf_protection', '~> 1.0' # OmniAuth Auth0 strategy and CSRF protection
gem 'jwt'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'carrierwave', '~> 2.1'
gem 'carrierwave-base64'
gem 'mini_magick', '~> 4.8'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary', '~> 0.12.6.5'
gem "fog-aws"
gem 'aws-sdk', '~> 3'
gem 'combine_pdf'
gem 'pdfcrowd', '~> 4.4', '>= 4.4.2'
gem 'pdf-reader'
gem 'kaminari', '~> 1.2.2' # pagination gem
gem 'rubyzip', '~> 2.3', '>= 2.3.2'
gem 'bourbon', '~> 7.2'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.7'
gem 'ransack', '~> 3.2', '>= 3.2.1'

# gem 'redis', '~> 3.0' # Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment
# gem 'administrate'
# gem 'wkhtmltopdf-binary', '~> 0.12.5'
# gem 'devise', '~> 4.7' # devise auth
# gem 'devise_token_auth' # devise auth
# gem 'omniauth' # devise auth
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes