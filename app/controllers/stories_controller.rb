class StoriesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @stories = Story.order(rank: :desc)
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.creator_id = current_user.id

    if @story.valid?
      @story.save
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    @story.assign_attributes(story_params)

    if @story.valid?
      @story.save
      redirect_to story_path(@story)
    else
      render :edit
    end
  end

  def vote
    story = Story.find(params[:story_id])
    story.vote(current_user, params[:vote])

    redirect_to stories_path
  end

  def destroy
    Story.destroy(params[:id])
    
    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit(
      :title, :subtitle, :snippet_length, :color, :dark_theme
    )
  end

end
