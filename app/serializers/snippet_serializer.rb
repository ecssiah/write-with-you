class SnippetSerializer < ActiveModel::Serializer
  attributes :id, :content, :paragraph_begin, :paragraph_end, :position
  belongs_to :story
end
