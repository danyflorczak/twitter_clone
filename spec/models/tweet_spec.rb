# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tweet, type: :model do
  it { should belong_to :user }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }
  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_users).through(:retweets).source(:user) }
  it { should have_many(:views).dependent(:destroy) }
  it { should have_many(:viewd_users).through(:views).source(:user) }
  it {
    should belong_to(:parent_tweet).with_foreign_key(:parent_tweet_id).class_name("Tweet").inverse_of(:reply_tweets).optional
  }
  it { should have_many(:reply_tweets).with_foreign_key(:parent_tweet_id).class_name("Tweet") }
  it { should have_and_belong_to_many(:hashtags) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }

  describe "saving hashtags" do
    let(:user) { create(:user) }
    context "when there are no matching hashtags in the body" do
      it "does not create hashtag" do
        expect do
          Tweet.create(user:, body: "Example tweet body")
        end.not_to change { Hashtag.count }
      end
    end

    context "when there are hashtags in the body" do
      it "creates hashtag" do
        expect do
          Tweet.create(user:, body: "Example tweet body with one #hashtag")
        end.to change { Hashtag.count }.by(1)
      end

      it "create hashtags assigned to the tweet" do
        tweet = Tweet.create(user:, body: "Example tweet body with #two #hashtags")
        expect(tweet.hashtags.size).to eq(2)
      end
    end

    context "when there are duplicate hashtag in the body" do
      it "does not create hashtag if it is already in db" do
        Hashtag.create(tag: "hashtag")
        expect do
          Tweet.create(user:, body: "Example tweet body with one #hashtag")
        end.not_to change { Hashtag.count }
      end
    end
  end
end
