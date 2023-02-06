# frozen_string_literal: true

require "rails_helper"

RSpec.describe Like, type: :model do
  it { should belont_to :user }
  it { should belont_to :tweet }
end
