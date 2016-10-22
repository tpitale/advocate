class Interaction < ActiveRecord::Base

  belongs_to :client

  def self.active_for(user)
    where(id: Event.interactions_for(user), status: "open")
  end

end
