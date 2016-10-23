class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path
    else
      render :new
    end
  end

  private

    def client_params
      params.require(:client).permit(:phone, :first_name, :last_name, :last_address, :gender, :ssn, :ethnicity, :education, :employed, :veteran, :domestic_assault_victim, :mental_health, :kid_count, :birthdate)
    end
end