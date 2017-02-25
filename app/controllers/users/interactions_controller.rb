module Users
  class InteractionsController < Users::BaseController

    respond_to :html

    def index
      @interactions = Interaction.active_for(current_user).recent.includes(:events)
      @open_interactions = Interaction.no_replies.no_creator.recent.includes(:events)
    end

    def show
      @interaction = Interaction.find(params[:id])
      @client = @interaction.client
      @event = Event.new(interaction: @interaction, user: current_user)
    end

    def new
      client = Client.where(id: params[:client_id]).first
      if interaction = client.interactions.open.first
        redirect_to users_interaction_path(interaction)
      else
        phone = client.phone if client

        @interaction = Interaction.new(phone: phone)
      end
    end

    def create
      @interaction = Interaction.create(params[:interaction].permit(:phone).merge(status: "open", user: current_user))

      respond_with @interaction, location: [:users, @interaction]
    end

  end
end
