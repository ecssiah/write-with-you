class SnippetsController < ApplicationController
  before_action :require_login

  def show; end

  def new
    @story = Story.find(params[:story_id])
    @snippet = @story.snippets.build(position: params[:position])
  end

  def create
    @story = Story.find(params[:story_id])
    @snippet = @story.snippets.build(snippet_params)
    @snippet.user = current_user

    if @snippet.valid?
      @story.shift_snippets(params[:snippet][:position], 1)
      @snippet.save

      current_user.set_contribution_color(@story, params[:contribution_color])

      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def edit
    @story = Story.find(params[:story_id])
    @snippet = Snippet.find(params[:id])
  end

  def update
    @story = Story.find(params[:story_id])
    @snippet = Snippet.find(params[:id])
    @snippet.assign_attributes(snippet_params)

    if @snippet.valid?
      @snippet.save

      current_user.set_contribution_color(@story, params[:contribution_color])

      redirect_to story_path(@story)
    else
      render :edit
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
      :content, :paragraph_begin, :paragraph_end, :position
    )
  end

end
