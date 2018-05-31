class SessionsController < ApplicationController

  def new
  end

  def create
    omni_info = request.env['omniauth.auth']
    omni_info ? omni_auth(omni_info) : local_auth(params)
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def omni_auth(info)
    user = User.find_by(email: info['info']['email'])

    if !user
      flash[:error] = "Email does not match existing user"
      redirect_to login_path
    else
      login(user)
    end
  end

  def local_auth(info)
    user = User.find_by(email: info[:user][:email])

    if info[:user][:email].blank? || info[:user][:password].blank?
      flash[:error] = "Fields can't be left blank"
      redirect_to login_path
    elsif !user
      flash[:error] = "Email does not match existing user"
      redirect_to login_path
    elsif !user.authenticate(info[:user][:password])
      flash[:error] = "Password is not correct"
      redirect_to login_path
    else
      login(user)
    end
  end

end
