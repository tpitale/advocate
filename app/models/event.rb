class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :interaction

  has_one :client, through: :interaction

  def self.interactions_for(user)
    where(user: user).select(:interaction_id).uniq
  end

  def save
    super.tap do |result|
      queue_for_outbound if result
    end
  end

  private
  def queue_for_outbound
    # send to twilio
  end
end
