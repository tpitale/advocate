module InteractionsHelper
  def human_readable_boolean(boolean)
    boolean ? "Yes" : "No"
  end

  def human_readable_text(text)
    text.blank? ? "N/A" : text
  end
end