# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tweets", type: :request do
  describe "GET show" do
    it "have success http status" do
      tweet = create(:tweet)
      user = create(:user)
      sign_in user
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
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
