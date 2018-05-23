class SnippetsController < ApplicationController
  before_action :require_login

  def show
  end

  def new
    @story = Story.find(params[:story_id])
    @position = params[:position]
  end

  def create
    story = Story.find(params[:story_id])
    snippet = story.snippets.build(snippet_params)
    snippet.save

    story.shift_snippets(snippet.position, 1)
    story.save
    
    redirect_to story_path(story)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def snippet_params
    params.require(:snippet).permit(:content, :paragraph_begin, :paragraph_end, :position)
  end

end
