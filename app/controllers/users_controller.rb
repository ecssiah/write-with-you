class UsersController < ApplicationController
  before_action :require_login, except: [:index, :all, :info, :show, :new, :create] 

  def index
    render json: current_user.stories.order(rank: :desc), status: 200
  end

  def all
    render json: User.all, status: 200
  end

  def info
    render json: User.find(params[:id]), status: 200
  end

  def show
    @stories = User.created_stories(current_user)

    respond_to do |f|
      f.html
      f.json { render json: @stories, status: 200 }
    end
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

