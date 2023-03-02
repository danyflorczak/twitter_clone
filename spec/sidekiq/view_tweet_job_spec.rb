require 'rails_helper'
RSpec.describe ViewTweetJob, type: :job do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  subject do
    described_class.new.perform(tweet.id, user.id)
  end

  it "increments the view count if the tweet has not been viewd" do
    expect { subject }.to change { View.count }.by(1)
  end

  it "does not increment the view count if the tweet already has been viewd" do
    create(:view, user: user, tweet: tweet)
    expect { subject }.not_to change { View.count }
  end
end
