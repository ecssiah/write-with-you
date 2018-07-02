class StoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login, except: [:index, :show]

  def index
    @stories = Story.order(rank: :desc)
  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    @story = Story.create(story_params)

    if @story.valid? 
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def update
    @story = Story.find(params[:id])

    if @story.update(story_params)
      redirect_to story_path(@story)
    else
      render :edit
    end
  end

  def vote
    story = Story.find(params[:story_id])
    current_user.vote(story, params[:vote])

    redirect_to stories_path
  end

  def destroy
    Story.destroy(params[:id])
    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit(
      :creator_id, :title, :subtitle, :snippet_length, :color, :dark_theme
    )
  end

end
