class Provider < ActiveRecord::Base
  has_many :services, dependent: :destroy

  geocoded_by :full_address

  def full_address
    "#{address} #{city}, #{state} #{zip}"
  end
end
