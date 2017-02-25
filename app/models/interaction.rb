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
    joins("LEFT OUTER JOIN events ON interactions.id = events.interaction_id AND events.user_id IS NOT NULL").
    group("interactions.id").
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

  def self.open
    where(status: "open")
  end

  def self.active_for(user)
    where(["(id IN (?) OR user_id = ?) AND status = ?", Event.interactions_for(user), user.id, "open"])
  end

  def latest_event
    events.order(:created_at).first
  end

  def type
    events.any? ? events.first.source_type : ""
  end

  def open?
    status == "open"
  end

  def resolved?
    !open?
  end

  def last_contact
    events = Event.where(interaction: self)
    if events.any?
      events.max_by(&:created_at).created_at.strftime("%m/%d/%Y %l:%M %p")
    end
  end
end
