module Users
  class BaseController < ApplicationController
    # TODO: auth and constrain to user

    def current_user
      @current_user ||= User.first
    end

    helper_method :current_user
  end
end
