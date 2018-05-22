class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env['omniauth.auth']
      user = User.find_by(email: request.env['omniauth.auth']['info']['email'])
      
      if !user
        flash[:error] = "Email does not match existing user."
        redirect_to signup_path
      else
        login(user)
      end
    else
      user = User.find_by(email: params[:user][:email])

      if !user
        flash[:error] = "Email does not match existing user."
        redirect_to login_path
      elsif !user.authenticate(params[:user][:password])
        flash[:error] = "Password is not correct."
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
