class SnippetsController < ApplicationController
  before_action :require_login

  def show
  end

  def new
    @story = Story.find(params[:story_id])
    @snippet = Snippet.new

    @position = params[:position]
  end

  def create
    @snippet = Snippet.new(snippet_params)
    @snippet.user = current_user

    @story = Story.find(params[:story_id])
    @story.snippets << @snippet

    if @snippet.valid?
      @story.shift_snippets(params[:snippet][:position], 1)
      @snippet.save
      redirect_to story_path(@story)
    else
      @position = snippet_params[:position]
      render :new
    end
  end

  def edit
    @story = Story.find(params[:story_id])
    @snippet = Snippet.find(params[:id])

    @prev_snippet = Snippet.find_by(position: @snippet.position - 1)
    @next_snippet = Snippet.find_by(position: @snippet.position + 1)
  end

  def update
    @story = Story.find(params[:story_id])

    @snippet = Snippet.find(params[:id])
    @snippet.assign_attributes(snippet_params)

    if @snippet.valid?
      @snippet.save
      redirect_to story_path(@snippet.story)
    else
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
    params.require(:snippet).permit(:content, :paragraph_begin, :paragraph_end, :position)
  end

end
