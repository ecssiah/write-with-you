class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def self.update_rankings(story)
    contributions = self.where(story: story) 
    story.update(rank: contributions.sum(&:vote) / total_votes(story).to_f)
  end

  def self.total_votes(story)
    contributions = self.where(story: story)
    contributions.select { |contribution| contribution.vote > 0 }.size 
  end

end
