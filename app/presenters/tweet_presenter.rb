# frozen_string_literal: true

class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = user
  end

  attr_reader :tweet, :current_user

  delegate :user, :body, :likes_count, to: :tweet
  delegate :display_name, :username, :avatar, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def like_tweet_url
    if tweet_liked_by_current_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet:))
    else
      tweet_likes_path(tweet)
    end
  end

  def turbo_like_data_method
    if tweet_liked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def like_heart_image
    if tweet_liked_by_current_user?
      "heart-filled.png"
    else
      "heart-unfilled.png"
    end
  end

  def bookmark_tweet_url
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet:))
    else
      tweet_bookmarks_path(tweet)
    end
  end

  def turbo_bookmark_data_method
    if tweet_bookmarked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def bookmark_image
    if tweet_bookmarked_by_current_user?
      "bookmark-filled.png"
    else
      "bookmark-unfilled.png"
    end
  end

  def bookmark_text
    if tweet_bookmarked_by_current_user?
      "Bookmarked"
    else
      "Bookmark"
    end
  end

  private

  def tweet_liked_by_current_user
    @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
  end
  alias tweet_liked_by_current_user? tweet_liked_by_current_user

  def tweet_bookmarked_by_current_user
    @tweet_bookmarked_by_current_user ||= tweet.bookmarked_users.include?(current_user)
  end
  alias tweet_bookmarked_by_current_user? tweet_bookmarked_by_current_user
end
