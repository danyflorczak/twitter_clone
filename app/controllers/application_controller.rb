class ApplicationController < ActionController::Base
  protected

  def after_signed_in(resource)
    dashboard_path
  end
end
