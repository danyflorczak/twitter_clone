# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }

  describe "#set_display_name" do
    context "when display_name is set" do
      it "does not change the display_name" do
        user = build(:user, username: "bombel", display_name: "daniel florczak")
        user.save
        expect(user.reload.display_name).to eq("daniel florczak")
      end
    end

    context "when display_name is not set" do
      it "humanizes the previously set username" do
        user = build(:user, username: "bombel", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("Bombel")
      end
    end
  end
end
