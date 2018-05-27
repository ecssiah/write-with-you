class StoriesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)

    if @story.valid?
      Contribution.create(story: @story, user: current_user)

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
    contribution = Contribution.find_by(story: story, user: current_user)
    contribution.update(vote: params[:vote])

    Contribution.update_rankings(story)

    puts story.rank

    redirect_to stories_path
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
