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
    story.shift_snippets(params[:snippet][:position], 1)

    snippet = story.snippets.build(snippet_params)
    snippet.user = current_user
    snippet.save
    
    redirect_to story_path(story)
  end

  def edit
    @story = Story.find(params[:story_id])
    @snippet = Snippet.find(params[:id])

    # TODO: These are not displaying correctly.

    @prev_snippet = Snippet.find_by(position: @snippet.position - 1)
    @next_snippet = Snippet.find_by(position: @snippet.position + 1)
  end

  def update
    snippet = Snippet.find(params[:id])
    snippet.update(snippet_params)

    redirect_to story_path(snippet.story)
  end

  def destroy
    snippet = Snippet.find(params[:id])
    story = Story.find(params[:story_id])
    story.shift_snippets(snippet.position, -1)

    Snippet.destroy(params[:id])

    redirect_to story_path(story)
  end

  private

  def snippet_params
    params.require(:snippet).permit(:content, :paragraph_begin, :paragraph_end, :position)
  end

end
