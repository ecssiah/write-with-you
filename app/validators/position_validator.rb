class PositionValidator < ActiveModel::Validator
  def validate(snippet)
    total_snippets = snippet.story.snippets.size

    unless snippet.position.between?(0, total_snippets)
      snippet.position = [0, snippet.position, total_snippets - 1].sort[1]
      snippet.errors.add(:position, "was moved into range")
    end 
  end
end
