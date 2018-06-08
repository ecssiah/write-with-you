class PositionValidator < ActiveModel::Validator
  def validate(snippet)
    last_position = snippet.story.snippets.size - 1

    unless snippet.position.between?(0, last_position)
      invalid_pos = snippet.position
      snippet.position = [0, snippet.position, last_position].sort[1]

      snippet.errors.add(
        :position, "was moved from #{invalid_pos} to #{snippet.position}"
      )
    end 
  end
end
