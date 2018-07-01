class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :color, :snippet_length, :dark_theme, :creator_id, :rank
end
