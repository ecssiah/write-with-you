class SnippetSerializer < ActiveModel::Serializer
  attributes :id, :content, :paragraph_begin, :paragraph_end, :position, :user_id

  belongs_to :story
  belongs_to :user
end
