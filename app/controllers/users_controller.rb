class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create] 

  def index
  end

  def new
  end

  def create
    fields = params[:user]

    fields_empty = fields[:email].blank? || fields[:password].blank?

    if fields_empty
      flash[:error] = "Email and Password are required."
      redirect_to signup_path
      return
    end

    password_mismatch = fields[:password] != fields[:confirm_pass]

    if password_mismatch
      flash[:error] = "Password confirm does not match."
      redirect_to signup_path
      return
    end

    email_in_use = User.find_by(email: fields[:email])

    if email_in_use
      flash[:error] = "That email is already in use."
      redirect_to signup_path
      return
    end

    if fields[:username].blank?
      fields[:username] = "Anonymous"
    end

    user = User.create(user_params)

    login(user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
