class Story < ApplicationRecord
  belongs_to :user
  has_many :snippets, dependent: :destroy

  def shift_snippets(index, shift)
    elements_to_shift = self.snippets.where("position >= ?", index)
    elements_to_shift.update_all("position = position + #{shift}") 
  end

  def ordered_snippets 
    self.snippets.order(:position)
  end

  def display_title
    display = self.title

    if !self.subtitle.blank?
      display += ": <em>#{self.subtitle}</em>"
    end

    display.html_safe
  end

end
