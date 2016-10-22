module Users
  class ServicesController < Users::BaseController

    def index
      @services = ServiceSearch.new(params).results
    end

  end
end
