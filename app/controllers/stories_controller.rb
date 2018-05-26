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
    contribution = Contribution.create(story: Story.create(story_params), user: current_user)

    redirect_to story_path(contribution.story)
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
    params.require(:story).permit(
      :creator_id, :title, :subtitle, :snippet_length, :color, :dark_theme)
  end

end
