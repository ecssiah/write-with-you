class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def self.update_rankings(story)
    contributions = self.where(story: story) 
    
    total = 0
    contributions.each { |contribution| total += contribution.vote }

    story.rank = total / contributions.count.to_f
  end

end
