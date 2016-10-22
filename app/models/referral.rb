class Referral < ActiveRecord::Base
  belongs_to :interaction
  belongs_to :service

  DIGITS = 1_000_000

  # TODO: do more to prevent code collision
  def self.generate_code
    (SecureRandom.random_number * DIGITS).to_i
  end
end
