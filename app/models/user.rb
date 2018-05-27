class User < ApplicationRecord
  has_secure_password

  has_many :contributions
  has_many :stories, through: :contributions
  has_many :snippets, through: :stories

  validates :email, presence: true 

  validates_with AccountValidator

  def get_contribution(story)
    Contribution.find_or_create_by(user: self, story: story) 
  end

  def get_contribution_color(story)
    contribution = get_contribution(story)
    "##{contribution.color}" if contribution
  end

  def get_vote(story)
    contribution = get_contribution(story)
    contribution.vote
  end

end
