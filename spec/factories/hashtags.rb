# frozen_string_literal: true

FactoryBot.define do
  factory :hashtag do
    tag { Faker::Lorem.word }
  end
end
