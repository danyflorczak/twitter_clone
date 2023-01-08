# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!
  def create
    tweet = Tweet.new(tweets_params.merge(user: current_user))

    return unless tweet.save

    redirect_to dashboard_path
  end

  private

  def tweets_params
    params.require(:tweet).permit(:body)
  end
end
