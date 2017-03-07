class ApplicationController < ActionController::Base
  include SessionsHelper
  def hello
  end

  def not_found
    raise ActionController::RoutingError.new("not found")
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please_login"
      redirect_to login_url
    end
  end
end
