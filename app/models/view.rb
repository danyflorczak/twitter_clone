class View < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :user_id, uniqueness: { scope: :tweet_id }
end
