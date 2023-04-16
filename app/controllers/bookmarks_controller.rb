# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_presenter = current_user.bookmarked_tweets.map do |tweet|
      TweetPresenter.new(tweet:, current_user:)
    end
  end

  def create
    @bookmark = current_user.bookmarks.create(tweet:)

    return unless @tweet.save

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @bookmark = tweet.bookmarks.find(params[:id])
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end
