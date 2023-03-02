# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tweets", type: :request do
  describe "GET show" do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet) }

    before do
      sign_in user
      allow(ViewTweetJob).to receive(:perform_async)
    end

    it "have success http status" do
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
    end

    it "queues up ViewdTweetJob" do
      get tweet_path(tweet)
      expect(ViewTweetJob).to have_received(:perform_async)
    end
  end

  describe "POST create" do
    context "when signed in" do
      it "is create a new tweet" do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: {
            tweet: {
              body: "New tweet body",
            },
          }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when not signed in" do
      it "respond with redirect" do
        post tweets_path, params: {
          tweet: {
            body: "New tweet body",
          },
        }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
