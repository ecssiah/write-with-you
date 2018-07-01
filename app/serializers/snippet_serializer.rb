class SnippetSerializer < ActiveModel::Serializer
  attributes :id, :content, :paragraph_begin, :paragraph_end, :position
end
