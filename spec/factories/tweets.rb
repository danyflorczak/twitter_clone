# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    user
    body { Faker::Lorem.paragraph }
  end
end
