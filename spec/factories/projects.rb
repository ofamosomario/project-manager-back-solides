# frozen_string_literal: true

# spec/factories/projects.rb
FactoryBot.define do
  factory :project do
    name { Faker::Company.name }
    start_date { Faker::Date.backward(days: 30) }
    end_date { Faker::Date.forward(days: 120) }
  end
end
