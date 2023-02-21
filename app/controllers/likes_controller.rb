# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.likes.create(tweet:)

    return unless @tweet.save

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @like = tweet.likes.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end
