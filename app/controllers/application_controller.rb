class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :raise_error

  def raise_error
    raise "Test error raising"
  end
end
