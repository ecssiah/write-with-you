class Story < ApplicationRecord
  has_many :snippets, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :users, through: :contributions

  validates :title, presence: true

  def creator
    @creator ||= User.find(self.creator_id)
  end

  def has_snippets?
    self.snippets.present?
  end

  def shift_snippets(index, shift)
    elements_to_shift = self.snippets.where("position >= ?", index)
    elements_to_shift.update_all("position = position + #{shift}") 
  end

  def ordered_snippets 
    self.snippets.order(:position)
  end

  def display_title
    display = self.title
    display += ": <em>#{self.subtitle}</em>" if self.subtitle.present?
    display.html_safe
  end

end
