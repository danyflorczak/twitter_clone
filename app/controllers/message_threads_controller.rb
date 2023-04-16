# frozen_string_literal: true

class MessageThreadsController < ApplicationController
  before_action :authenticate_user!

  def index
    return unless params[:user_id].present?
    @new_message_thread_user = User.find(params[:user_id])
  end
end
