# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def show
    ViewTweetJob.perform_async(tweet.id, current_user.id)
    @tweet_presenter = TweetPresenter.new(tweet:, current_user:)
    @reply_tweets_in_presenter = tweet.reply_tweets.includes(:liked_users, :bookmarked_users, :retweeted_users,
                                                             :user).order(created_at: :desc).map do |reply_tweet|
      TweetPresenter.new(tweet: reply_tweet, current_user:)
    end
  end

  def create
    @tweet = Tweet.new(tweets_params.merge(user: current_user))

    return unless @tweet.save

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def tweets_params
    params.require(:tweet).permit(:body)
  end

  def tweet
    @tweet ||= Tweet.find(params[:id])
  end
end
