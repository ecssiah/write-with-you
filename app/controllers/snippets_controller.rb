class SnippetsController < ApplicationController
  before_action :require_login

  def show
  end

  def new
    @story = Story.find(params[:story_id])
    @snippet = Snippet.new

    @contribution_color = current_user.get_contribution_color(@story)

    @position = params[:position]
  end

  def create
    @story = Story.find(params[:story_id])
    @snippet = @story.snippets.build(snippet_params)
    @snippet.user = current_user

    if @snippet.valid?
      @story.shift_snippets(params[:snippet][:position], 1)
      @snippet.save

      contribution = Contribution.find_or_create_by(story: @story, user: current_user)
      contribution.update(color: params[:contribution_color])

      redirect_to story_path(@story)
    else
      @position = snippet_params[:position]
      @contribution_color = params[:contribution_color]
      render :new
    end
  end

  def edit
    @story = Story.find(params[:story_id])
    @snippet = Snippet.find(params[:id])

    @contribution_color = current_user.get_contribution_color(@story)

    @prev_snippet = Snippet.find_by(story: @story, position: @snippet.position - 1)
    @next_snippet = Snippet.find_by(story: @story, position: @snippet.position + 1)
  end

  def update
    @story = Story.find(params[:story_id])

    @snippet = Snippet.find(params[:id])
    @snippet.assign_attributes(snippet_params)

    if @snippet.valid?
      @snippet.save

      contribution = Contribution.find_or_create_by(story: @story, user: current_user)
      contribution.update(color: params[:contribution_color])

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
    story = Story.find(params[:story_id])
    story.shift_snippets(snippet.position, -1)

    Snippet.destroy(params[:id])

    redirect_to story_path(story)
  end

  private

  def snippet_params
    params.require(:snippet).permit(
      :content, :paragraph_begin, :paragraph_end, :position)
  end

end
