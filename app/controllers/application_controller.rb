class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def logged_in?
    session.include?(:user_id)
  end

  def login(user)
    session[:user_id] = user.id
    redirect_to users_path 
  end

  def require_login
    return head(:forbidden) unless logged_in?
  end

end

