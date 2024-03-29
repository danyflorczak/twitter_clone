# frozen_string_literal: true

FactoryBot.define do
  factory :following do
    user
    following_user do
      create(:user)
    end
  end
end
