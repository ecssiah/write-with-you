class StoriesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
  end

  def create
    story = current_user.stories.build(story_params)
    story.save

    redirect_to story_path(story)
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    story = Story.find(params[:id])
    story.update(story_params)
    story.save

    redirect_to story_path(story)
  end

  def destroy
    Story.destroy(params[:id])
    
    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit(:title, :subtitle, :snippet_length, :color)
  end

end
