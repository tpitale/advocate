class Client < ActiveRecord::Base
  validates :phone, presence: true, uniqueness: true
end
