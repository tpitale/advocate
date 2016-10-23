class Referral < ActiveRecord::Base
  belongs_to :interaction
  belongs_to :service

  has_one :provider, through: :service

  DIGITS = 1_000_000

  # TODO: do more to prevent code collision
  def self.generate_code
    (SecureRandom.random_number * DIGITS).to_i
  end

  def provider_name
    provider.name
  end

  def service_name
    service.name
  end

  def resolved?
    status == "resolved"
  end

  def title
    "Client Referred to #{provider_name} for #{service_name}"
  end
end
