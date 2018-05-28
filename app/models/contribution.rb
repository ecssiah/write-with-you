class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def self.update_rankings(story)
    contributions = self.where(story: story) 
    
    total = 0
    contributions.each { |contribution| total += contribution.vote }

    story.update(rank: total / total_votes(story).to_f)
  end

  def self.total_votes(story)
    contributions = self.where(story: story)

    contributions.select { |contribution| contribution.vote.present? }.size 
  end

end
