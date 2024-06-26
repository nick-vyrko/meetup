# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@mail.com" }
    password { '123123' }
  end
end
