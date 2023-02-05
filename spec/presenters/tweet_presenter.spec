# frozen_string_literal: true

require "rails_helper"

RSpec.describe TweetPresenter, type: :presenter do
  describe "#created_at" do
    context "when tweet is created more than 24h ago" do
      before { travel_to Time.local(2008, 9, 3, 10, 5, 0) }
      after { travel_back }
      it "displays shortend date" do
        tweet = create(:tweet)
        tweet.update! created_at: 2.days.ago
        expect(TweetPresenter.new(tweet).created_at).to eq("Sep 1")
      end
    end

    context "when tweet is created no more than 24 hours ago" do
      it "displays date in words" do
        tweet = create(:tweet)
        tweet.update! created_at: 2.hours.ago
        expect(TweetPresenter.new(tweet).created_at).to eq("about 2 hours")
      end
    end
  end
end
