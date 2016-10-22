module Users
  module Interactions
    class ClientsController < ApplicationController
      def edit
        @client = Client.find(params[:client_id])
      end
    end
  end
end