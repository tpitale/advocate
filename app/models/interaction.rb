class Interaction < ActiveRecord::Base
  has_many :events
  has_many :referrals # most likely, just one

  has_one :referral

  belongs_to :client
  belongs_to :user # created by user

  attr_reader :phone

  def phone=(search)
    self.client = Client.with_phone(search)
    @phone = client.phone
  end

  def self.no_replies_ids
    select("interactions.id").
    joins("LEFT OUTER JOIN events ON interactions.id = events.interaction_id").
    group("interactions.id").
    where("events.user_id IS NULL").
    having("count(events.id) = 0")
  end

  def self.no_replies
    where(id: no_replies_ids)
  end

  def self.no_creator
    where(user_id: nil)
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

  def type
    events.first.source_type
  end
end
