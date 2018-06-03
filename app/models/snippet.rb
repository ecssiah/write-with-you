class Snippet < ApplicationRecord
  belongs_to :user
  belongs_to :story

  validates :content, presence: true

  validates_with PositionValidator

  def prev
    Snippet.find_by(story: self.story, position: self.position - 1) 
  end

  def next(new = false)
    pos = new ? self.position : self.position + 1 
    Snippet.find_by(story: self.story, position: pos)
  end

end

