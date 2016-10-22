class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :interaction

  has_one :client, through: :interaction

  def self.interactions_for(user)
    where(user: user).select(:interaction_id).uniq
  end

  def save
    super.tap do |result|
      queue_for_outbound if result && deliver?
    end
  end

  private
  def deliver?
    # outbound if user_id is set
    # outbound if sms reply
    user_id.present? && source_type == "sms"
  end

  def client
    interaction.client
  end

  def queue_for_outbound
    # send to twilio
    # HACK
    # Not resilient to Twilio outages
    # Thread.new do
      tw = Twilio::REST::Client.new(TWILIO_ACCOUNT_ID, TWILIO_AUTH_TOKEN)

      begin
        tw.messages.create({
          from: TWILIO_PHONE_NUMBER,
          to: client.phone,
          body: content
        })
      rescue Twilio::REST::RequestError => e
        p e.message
      end
    # end
  end
end
