class ApplicationController < ActionController::Base

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

