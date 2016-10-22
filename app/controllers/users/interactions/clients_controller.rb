module Users
  module Interactions
    class ClientsController < ApplicationController
      def edit
        @interaction = Interaction.find(params[:interaction_id])
        @client = Client.find(params[:id])
      end

      def update
        @interaction = Interaction.find(params[:interaction_id])
        @client = Client.find(params[:id])
        if @client.update_attributes(client_params)
          redirect_to users_interaction_path(@interaction)
        else
          render :edit
        end
      end

      private

        def client_params
          params.require(:client).permit(:phone, :first_name, :last_name, :last_address, :gender, :ssn, :ethnicity, :education, :employed, :veteran, :domestic_assault_victim, :mental_health, :kid_count, :birthdate)
        end
    end
  end
end