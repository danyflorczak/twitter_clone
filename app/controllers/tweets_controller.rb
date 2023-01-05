class TweetsController < ApplicationController
  def create
    tweet = Tweet.new(tweets_params.merge(user: current_user))

    if tweet.save
      redirect_to root_path
    end
  end

  private

  def tweets_params
    params.require(:tweet).permit(:body)
  end
end