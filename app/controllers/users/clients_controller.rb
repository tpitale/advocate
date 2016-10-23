module Users
  class ClientsController < ApplicationController
    def edit
      @client = Client.find(params[:id])
    end

    def update
      @client = Client.find(params[:id])
      if @client.update_attributes(client_params)
        if params["search_path"].present?
          redirect_to users_services_path(service_name: params["search_path"], interaction_id: @client.interactions.last.id)
        else
          redirect_to users_interactions_path
        end
      else
        render :edit
      end
    end

    def index
      @clients = Client.all
    end

    def new
      @client = Client.new
    end

    def create
      @client = Client.new(client_params)
      if @client.save
        redirect_to users_clients_path
      else
        render :new
      end
    end

    private

      def client_params
        params.require(:client).permit(:phone, :first_name, :last_name, :last_address, :gender, :ssn, :ethnicity, :education, :employed, :veteran, :domestic_assault_victim, :mental_health, :kid_count, :birthdate)
      end
  end
end
