class Client < ActiveRecord::Base
  validates :phone, presence: true, uniqueness: true

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
end
