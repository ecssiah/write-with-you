class ApplicationController < ActionController::Base

  def login(user)
    session[:user_id] = user.id
    redirect_to users_path 
  end

end

