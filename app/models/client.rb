class Client < ActiveRecord::Base
  validates :phone, presence: true, uniqueness: true

  has_many :interactions

  def self.with_phone(search)
    normalized_phone = search.length == 10 ? "+1"+search : search

    where(phone: normalized_phone).first
  end

  def male?
    ["man", "male", "guy", "dude"].include? gender.to_s.downcase
  end

  def female?
    ["woman", "female", "lady"].include? gender.to_s.downcase
  end

  def ssn?
    ssn.present?
  end

  def family?
    kid_count.to_i > 0
  end

  def name
    "#{first_name} #{last_name}"
  end

  def formatted_birthdate
    birthdate && birthdate.strftime("%B %e, %Y")
  end

  def contact_types
    types = interactions.map(&:type).uniq.compact
    types.any? ? types.join(", ") : "No contact types"
  end

  def last_contacted
    events = Event.where(interaction: interactions)
    if events
      events.max_by(&:created_at).created_at.strftime("%m/%d/%Y %l:%M %p")
    end
  end
end
