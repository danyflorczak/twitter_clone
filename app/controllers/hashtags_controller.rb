# frozen_string_literal: true

class HashtagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @hashtags = Hashtag.includes(:tweets)
  end

  def show
    @hashtag = Hashtag.find(params[:id])
    @tweet_presenters = @hashtag.tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet:, current_user:)
    end
  end
end
