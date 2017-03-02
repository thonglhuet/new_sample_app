class ApplicationController < ActionController::Base
  include SessionsHelper
  def hello
  end

  def not_found
    raise ActionController::RoutingError.new("not found")
  end
end
