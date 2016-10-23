class Service < ActiveRecord::Base
  belongs_to :provider
  attr_accessor :disqualified, :qualified

  def qualify_and_disqualify(client)
    disqualify(client)
    qualify(client)
  end

  def disqualify(client)
    return false unless name == "Emergency Shelter"
    if female && client.male?
      self.disqualified = "Client is not currently eligible for this service based on gender restrictions.  Please confirm gender."
    elsif male && client.female?
      self.disqualified = "Client is not currently eligible for this service based on gender restrictions.  Please confirm gender."
    elsif ssn && !client.ssn?
      self.disqualified = "Client is not currently eligible for this service due to lack of SS#.  Please confirm with client."
    end
  end

  def qualify(client)
    return false unless name == "Emergency Shelter"
    if family? && client.family?
      self.qualified = "Client is eligible for this service based on family."
    elsif female && client.female?
      self.qualified = "Client is eligible for this service based on gender."
    elsif male && client.male?
      self.qualified = "Client is eligible for this service based on gender."
    elsif ssn && client.ssn?
      self.qualified = "Client is eligible for this service due based on presence of SS#."
    end
  end

  def sort_number
    if qualified.present?
      -1
    elsif disqualified.present?
      1
    else
      0
    end
  end
end
