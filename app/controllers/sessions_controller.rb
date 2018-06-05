class SessionsController < ApplicationController

  def new; end

  def create
    if (omni_info = request.env['omniauth.auth'])
      verify(User.find_by(email: omni_info['info']['email']), omni_info)
    else
      verify(User.find_by(email: params[:user][:email]), params)
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def verify(user, info)
    if (flash[:error] = User.auth_error(user, info))
      redirect_to login_path
    else
      login(user)
    end
  end

end

