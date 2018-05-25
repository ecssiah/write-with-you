class User < ApplicationRecord
  has_secure_password

  has_many :contributions
  has_many :stories, through: :contributions
  has_many :snippets, through: :stories

  def get_contribution_color(story)
    Contribution.find_by(user: self, story: story).color 
  end
end
