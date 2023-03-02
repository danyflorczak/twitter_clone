class ViewTweetJob
  include Sidekiq::Job

  def perform(tweet_id, user_id)
    tweet = Tweet.find(tweet_id)
    user = User.find(user_id)

    View.create(tweet: tweet, user: user) unless tweet_viewed?(tweet: tweet, user: user)
  end

  private

  def tweet_viewed?(tweet:, user:)
    View.exists?(user: user, tweet: tweet)
  end
end