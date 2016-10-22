class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :interaction

  def self.interactions_for(user)
    where(user: user).select(:interaction_id).uniq
  end
end
