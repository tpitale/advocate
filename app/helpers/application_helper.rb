module ApplicationHelper
  def current_user_id
    tag(:meta, name: 'current_user_id', id: 'current_user_id', value: current_user.id) if logged_in?
  end

  def current_user_token
    tag(:meta, name: 'current_user_token', id: 'current_user_token', value: current_user.token) if logged_in?
  end
end
