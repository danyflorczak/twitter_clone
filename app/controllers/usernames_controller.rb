# frozen_string_literal: true

class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username_form

  def new; end

  def update
    if invalid_username?
      flash[:alert] = "Please Set a Username"
      redirect_to new_username_path
    else
      update_username
      redirect_to dashboard_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username, :username_params, :avatar)
  end

  def invalid_username?
    username_params[:username].blank?
  end

  def update_username
    if current_user.update(username_params)
      flash[:notice] = "Username successfully updated"
    else
      flash[:alert] = current_user.errors.full_messages.join(", ")
    end
  end
end
