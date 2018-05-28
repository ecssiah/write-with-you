class User < ApplicationRecord
  has_secure_password

  has_many :contributions, dependent: :destroy
  has_many :stories, through: :contributions
  has_many :snippets, through: :stories

  validates :email, presence: true 

  validates_with AccountValidator

  def get_contribution(story)
    Contribution.find_by(user: self, story: story) 
  end

  def get_contribution_color(story)
    contribution = get_contribution(story)
    "##{contribution.color}" if contribution
  end

  def set_contribution_color(story, color)
    contribution = Contribution.find_or_create_by(story: story, user: self)
    contribution.update(color: color)
  end

  def get_vote(story)
    contribution = get_contribution(story)
    contribution ? contribution.vote : 0
  end

end
