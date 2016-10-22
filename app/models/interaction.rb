class Interaction < ActiveRecord::Base
  has_many :events
  has_many :referrals # most likely, just one

  belongs_to :client

  def self.active_for(user)
    where(id: Event.interactions_for(user), status: "open")
  end

  def latest_event
    events.order(:created_at).first
  end
end
