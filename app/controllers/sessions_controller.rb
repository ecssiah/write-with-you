class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      login(user)
    else
      redirect_to signup_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end
