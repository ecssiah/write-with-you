class StoriesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def story_params
    params.require(:story).permit(:title, :subtitle, :snippet_length, :color)
  end

end
