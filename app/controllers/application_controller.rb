class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # STUB for application_helper
  def logged_in?
    false
  end
  helper_method :logged_in?
end
