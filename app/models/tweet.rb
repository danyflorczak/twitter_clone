# frozen_string_literal: true

class Tweet < ApplicationRecord
  HASHTAG_REGEX = /(#\w+)/

  belongs_to :user

  validates :body, presence: true, length: { maximum: 280 }
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user
  has_many :views, dependent: :destroy
  has_many :viewd_users, through: :views, source: :user
  has_and_belongs_to_many :hashtags
  belongs_to :parent_tweet, inverse_of: :reply_tweets, foreign_key: :parent_tweet_id, class_name: "Tweet",
                            optional: true, counter_cache: :reply_tweets_count
  has_many :reply_tweets, foreign_key: :parent_tweet_id, class_name: "Tweet"

  before_save :parse_and_save_hashtag
  def parse_and_save_hashtag
    matches = body.scan(HASHTAG_REGEX)
    return if matches.empty?

    matches.flatten.each do |tag|
      hashtag = Hashtag.find_or_create_by(tag: tag.remove("#"))
      hashtags << Hashtag.find_or_create_by(tag: tag.remove("#"))
    end
  end
end
