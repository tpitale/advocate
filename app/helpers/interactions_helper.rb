module InteractionsHelper
  def human_readable_boolean(boolean)
    boolean ? "Yes" : "No"
  end

  def human_readable_text(text)
    text.blank? ? "N/A" : text
  end

  def icon_class_for_interaction(interaction_type)
    case interaction_type
    when "sms"
      "fa-comments"
    when "phone"
      "fa-phone"
    when "in_person"
      "fa-user"
    when "location"
      "fa-map-marker"
    else
      "fa-comments"
    end
  end

  def type_of_interaction(interaction_type)
    case interaction_type
    when "sms"
      "SMS Interaction"
    when "phone"
      "Phone Interaction"
    when "in_person"
      "In-Person Interaction"
    when "location"
      "Client Shared Location"
    else
      "SMS Interaction"
    end
  end
end