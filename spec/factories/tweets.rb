# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    user { nil }
    body { "MyString" }
  end
end
