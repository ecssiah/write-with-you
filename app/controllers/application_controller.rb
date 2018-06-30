class ApplicationController < ActionController::Base

  def login(user)
    session[:user_id] = user.id
    redirect_to user_path(current_user) 
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    return head(:forbidden) unless logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end

