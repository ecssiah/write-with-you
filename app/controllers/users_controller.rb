class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create] 

  def show
    @stories = User.created_stories(current_user)
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
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation
    )
  end
end

