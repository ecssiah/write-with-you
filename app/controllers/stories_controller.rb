class StoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login, except: [:index, :body, :show]

  def index
    @stories = Story.order(rank: :desc)

    respond_to do |f|
      f.html
      f.json { render json: @stories, status: 200 }
    end
  end

  def body
    story = Story.find(params[:story_id])

    render json: story.ordered_snippets, status: 200 
  end

  def show
    @story = Story.find(params[:id])

    respond_to do |f|
      f.html
      f.json { render json: @story, status: 200 }
    end
  end

  def create
    story = Story.create(story_params)

    if story.valid? 
      render json: story, status: 200
    end
  end

  def update
    story = Story.find(params[:id])

    if story.update(story_params)
      render json: story, status: 200
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
