class PositionValidator < ActiveModel::Validator
  def validate(record)
    total_snippets = record.story.snippets.size

    unless record.position.between?(0, total_snippets)
      record.position = [0, record.position, total_snippets - 1].sort[1]
      record.errors.add(:position, "was moved into range")
    end 
  end
end
