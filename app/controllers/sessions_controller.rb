class SessionsController < ApplicationController

  def new
  end

  def create
    omni_info = request.env['omniauth.auth']
    
    if omni_info
      user = User.find_by(email: omni_info['info']['email'])

      if !user
        flash[:error] = "email does not match existing user"
        redirect_to login_path
      else
        login(user)
      end
    else
      user = User.find_by(email: params[:user][:email])

      if params[:user][:email].blank? || params[:user][:password].blank?
        flash[:error] = "fields can't be left blank"
        redirect_to login_path
      elsif !user
        flash[:error] = "email does not match existing user"
        redirect_to login_path
      elsif !omni_info && !user.authenticate(params[:user][:password])
        flash[:error] = "password is not correct"
        redirect_to login_path
      else
        login(user)
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end
