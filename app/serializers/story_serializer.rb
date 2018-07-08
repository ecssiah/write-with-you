class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, 
    :color, :snippet_length, :dark_theme, :creator_id, :rank

  has_many :snippets
  has_many :contributions
end
