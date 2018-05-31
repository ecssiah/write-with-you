class Snippet < ApplicationRecord
  belongs_to :user
  belongs_to :story

  validates :content, presence: true

  def prev
    Snippet.find_by(story: self.story, position: self.position - 1) 
  end

  def next(edit = true)
    if edit
      Snippet.find_by(story: self.story, position: self.position + 1)
    else
      Snippet.find_by(story: self.story, position: self.position)
    end
  end

end

