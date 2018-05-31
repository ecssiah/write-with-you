class Story < ApplicationRecord
  has_many :contributions, dependent: :destroy
  has_many :users, through: :contributions
  has_many :snippets, dependent: :destroy

  validates :title, presence: true

  def creator
    @creator ||= User.find(self.creator_id)
  end

  def snippets?
    self.snippets.present?
  end

  def shift_snippets(index, shift)
    elements_to_shift = self.snippets.where("position >= ?", index)
    elements_to_shift.update_all("position = position + #{shift}") 
  end

  def ordered_snippets 
    self.snippets.order(:position)
  end

  def prev_snippet(snippet)
    Snippet.find_by(story: self, position: snippet.position - 1) 
  end

  def next_snippet(snippet, new = true)
    if new
      Snippet.find_by(story: self, position: snippet.position)
    else
      Snippet.find_by(story: self, position: snippet.position + 1)
    end
  end

  def display_title
    display = self.title
    display += ": <em>#{self.subtitle}</em>" if self.subtitle.present?
    display.html_safe
  end

  def display_rank
    sprintf('%.1f', self.rank)
  end

end
