class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :confirm_pass)
  end

end
