class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create] 

  def index
    @stories = current_user.stories.order(rank: :desc)
  end

  def new
    @user = User.new
  end

  def create
    params[:user][:username] = "anonymous" if params[:user][:username].blank?
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      login(@user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
