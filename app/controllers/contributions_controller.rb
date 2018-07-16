class ContributionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    contributions = Contribution.all
    render json: contributions, status: 200
  end

  def update
    contribution = Contribution.find_or_create_by(
      story_id: params[:contribution][:story_id], 
      user_id: params[:contribution][:user_id]
    ) 

    if contribution.update(contributions_params)
      render json: contribution, status: 200
    end
  end

  private

  def contributions_params
    params.require(:contribution).permit(
      :user_id, :story_id, :color, :vote
    )
  end

end
