module Users
  class ServicesController < Users::BaseController

    def index
      @services = Service.where(name: params["service_name"])
      # raise Service.all.map(&:name).uniq.sort.inspect
      # # @services = ServiceSearch.new(params).results
    end

  end
end

# Emergency Shelter", "Emergency Shelter", "Emergency Shelter", "Emergency Shelter",
#  "Emergency Shelter", "Emergency Shelter", "Emergency Shelter", "Emergency Shelter",
#  "Food Programs & Pantries", "Food Programs & Pantries", "Food Programs & Pantries",
#  "Food Programs & Pantries", "Food Programs & Pantries", "Utility Assistance", "Utility Assistance", "Utility Assistance
