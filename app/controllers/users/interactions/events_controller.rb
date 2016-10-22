module Users
  module Interactions
    class EventsController < Users::BaseController

      def create
        # TODO: create new event
        # TODO: queue to send SMS via twilio if appropriate
      end

      private
      def current_interaction
        @current_interaction ||= Interaction.find(params[:interaction_id])
      end
      helper_method :current_interaction
    end
  end
end
