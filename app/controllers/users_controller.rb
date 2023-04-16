# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to profile_path if params[:id].to_i == current_user.id
    @user = User.find(params[:id])
    @tweet_presenters = @user.tweets.map do |tweet|
      TweetPresenter.new(tweet:, current_user: @user)
    end
  end
end
