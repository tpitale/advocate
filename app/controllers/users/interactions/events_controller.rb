module Users
  module Interactions
    class EventsController < Users::BaseController

      def create
        @event = Event.create({
          user: current_user,
          interaction: current_interaction,
          content: params[:event][:content],
          source_type: source_type_from_commit
        })

        # TODO: queue to send SMS via twilio if appropriate

        redirect_to [:users, current_interaction]
      end

      private
      def current_interaction
        @current_interaction ||= Interaction.find(params[:interaction_id])
      end
      helper_method :current_interaction

      def source_type_from_commit
        case params[:commit].to_s.downcase
        when "reply"
          then "sms"
        else
          nil
        end
      end
    end
  end
end
