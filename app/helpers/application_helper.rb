module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session.include?(:user_id)
  end
end
