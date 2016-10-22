class Interaction < ActiveRecord::Base

  belongs_to :client

  def self.active_for(user)
    all(status: "open", user: user)
  end

end
