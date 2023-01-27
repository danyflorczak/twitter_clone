# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!
  def create
    @tweet = Tweet.new(tweets_params.merge(user: current_user))

    if @tweet.save
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    end
  end

  private

  def tweets_params
    params.require(:tweet).permit(:body)
  end
end
