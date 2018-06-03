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

  def display_title
    display = self.title
    display += ": <em>#{self.subtitle}</em>" if self.subtitle.present?
    display.html_safe
  end

  def vote(user, vote)
    return if vote.to_i.zero?

    contribution = Contribution.find_or_create_by(story: self, user: user)
    contribution.update(vote: vote)

    update_rankings
  end

  def display_rank
    sprintf('%.1f', self.rank)
  end

  def update_rankings
    contributions = Contribution.where(story: self) 
    total_votes = contributions.select { |contrib| contrib.vote > 0 }.size
    update(rank: contributions.sum(&:vote) / total_votes.to_f)
  end
end

