# spec/factories/activities.rb

FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence(word_count: 3) }
    start_date { Faker::Date.backward(days: 30) }
    end_date { Faker::Date.forward(days: 30) }
    finished { [true, false].sample }
    association :project
  end
end
