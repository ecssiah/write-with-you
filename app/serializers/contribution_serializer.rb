class ContributionSerializer < ActiveModel::Serializer
  attributes :id, :story_id, :user_id, :color, :vote

  belongs_to :story
  belongs_to :user
end
