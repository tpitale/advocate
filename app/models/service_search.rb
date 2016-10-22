class ServiceSearch
  def initialize(params)
    @interaction_id = params[:interaction_id]

    @category = params[:category]

    @city = params[:city]
    @state = params[:state]
  end

  def results
    Service.includes(:provider).where(conditions)
  end

  private
  def interaction
    @interaction ||= Interaction.find(@interaction_id)
  end

  def client
    @client ||= @interaction.client
  end

  def conditions
    {category: @category, provider: {}}.tap do |h|

      # location
      h[:provider][:city] = @city if @city
      h[:provider][:state] = @state if @state

      # restrictions
      h[:male] = true if client.male?
      h[:female] = true if client.female?
      h[:ssn] = true if client.ssn.present? # reverse of blank?
      h[:family] = true if client.family?
    end
  end
end
