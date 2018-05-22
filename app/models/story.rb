class Story < ApplicationRecord
  belongs_to :user
  has_many :contributions
  has_many :snippets

  def display_title
    display = self.title

    if !self.subtitle.blank?
      display += ": <em>#{self.subtitle}</em>"
    end

    display.html_safe
  end
end
