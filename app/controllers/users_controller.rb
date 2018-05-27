class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create] 

  def index
    @stories = Story.where(creator_id: current_user.id).order(rank: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.username = "anonymous" if @user.username.blank?
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
