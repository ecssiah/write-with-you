class SnippetsController < ApplicationController
  before_action :require_login

  def show
  end

  def new
    @story = Story.find(params[:story_id])
    @snippet = Snippet.new

    @position = params[:position]
    @contribution_color = current_user.get_contribution_color(@story)

    @prev_snippet = Snippet.find_by(story: @story, position: @position.to_i - 1)
    @next_snippet = Snippet.find_by(story: @story, position: @position.to_i)
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
      @position = snippet_params[:position]
      @contribution_color = params[:contribution_color]

      @prev_snippet = Snippet.find_by(story: @story, position: @position.to_i - 1)
      @next_snippet = Snippet.find_by(story: @story, position: @position.to_i)

      render :new
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
    @story = @snippet.story

    @contribution_color = current_user.get_contribution_color(@story)

    @prev_snippet = Snippet.find_by(story: @story, position: @snippet.position - 1)
    @next_snippet = Snippet.find_by(story: @story, position: @snippet.position + 1)
  end

  def update
    @snippet = Snippet.find(params[:id])
    @snippet.assign_attributes(snippet_params)
    @story = @snippet.story

    if @snippet.valid?
      @snippet.save

      current_user.set_contribution_color(@story, params[:contribution_color])

      redirect_to story_path(@story)
    else
      @contribution_color = current_user.get_contribution_color(@story)

      @prev_snippet = Snippet.find_by(story: @story, position: @snippet.position - 1)
      @next_snippet = Snippet.find_by(story: @story, position: @snippet.position + 1)

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
      :content, :paragraph_begin, :paragraph_end, :position)
  end

end
