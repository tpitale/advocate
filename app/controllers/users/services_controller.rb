module Users
  class ServicesController < Users::BaseController

    def index
      @services = Service.where(name: params[:service_name].strip)
      @interaction = Interaction.find(params[:interaction_id])
      @services.each{|s|s.qualify_and_disqualify(@interaction.client)}
      @services = @services.sort_by{|s|s.sort_number}
    end
  end

end
