module Users
  class ReferralsController < Users::BaseController

    respond_to :html

    def new
      @referral = Referral.new(
        code: Referral.generate_code, interaction_id: params[:interaction_id], service_id: params[:service_id])
    end

    def create
      @referral = Referral.create(params[:referral].permit(:code, :interaction_id, :service_id).merge(status: "open"))

      respond_with @referral, location: [:users, current_interaction]
    end

    private
    def current_interaction
      @current_interaction ||= Interaction.find(params[:interaction_id] || params[:referral][:interaction_id])
    end
  end
end
