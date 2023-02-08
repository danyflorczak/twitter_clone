# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.includes(user: :likes).order(created_at: :desc).map { |tweet| TweetPresenter.new(tweet) }
  end
end
