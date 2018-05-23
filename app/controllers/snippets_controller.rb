class SnippetsController < ApplicationController
  before_action :require_login

  def show
  end

  def new
    @story = Story.find(params[:story_id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
