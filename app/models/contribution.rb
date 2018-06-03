class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def snippets?
    self.story.snippets.any? { |snippet| snippet.user == self.user } 
  end
end

