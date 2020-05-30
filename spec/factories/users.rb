# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    'email { "user@test.com" }'
    'password { "asdfasdf" }'
    'password_confirmation { "asdfasdf" }'
  end

  factory :admin_user, class: 'AdminUser' do
    'email { "admin_user@test.com" }'
    'password { "asdfasdf" }'
    'password_confirmation { "asdfasdf" }'
  end
end
