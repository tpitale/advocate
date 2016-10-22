class Interaction < ActiveRecord::Base
  has_many :events
  has_many :referrals # most likely, just one

  belongs_to :client
  belongs_to :user # created by user

  attr_reader :phone

  def phone=(search)
    self.client = Client.with_phone(search)
    @phone = client.phone
  end

  def self.recent
    order("id DESC")
  end

  def self.active_for(user)
    where(["(id IN (?) OR user_id = ?) AND status = ?", Event.interactions_for(user), user.id, "open"])
  end

  def latest_event
    events.order(:created_at).first
  end
end
