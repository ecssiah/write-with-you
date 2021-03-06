class SnippetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login

  def show
    @snippet = Snippet.find(params[:id])
    render json: @snippet, status: 200    
  end

  def create
    @story = Story.find(params[:story_id])
    @snippet = @story.snippets.build(snippet_params)

    if @snippet.valid?
      @story.shift_snippets(@snippet.position, 1)
      @snippet.save

      current_user.set_contribution_color(@story, params[:contribution_color])
      render json: @story, status: 200
    end
  end

  def update
    @snippet = Snippet.find(params[:id])
    @story = @snippet.story

    if @snippet.update(snippet_params)
      current_user.set_contribution_color(@story, params[:contribution_color])
      render json: @story, status: 200
    end
  end

  def destroy
    snippet = Snippet.find(params[:id])
    snippet.story.shift_snippets(snippet.position, -1)
    snippet.destroy

    redirect_to story_path(snippet.story)
  end

  private

  def snippet_params
    params.require(:snippet).permit(
      :user_id, :content, :paragraph_begin, :paragraph_end, :position
    )
  end

end

