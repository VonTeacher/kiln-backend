# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    title { Faker::Job.title }
  end
end
