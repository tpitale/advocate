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
    birthdate.strftime("%B %e, %Y")
  end
end
