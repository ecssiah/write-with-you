class User < ApplicationRecord
  has_secure_password

  has_many :stories
  has_many :contributions, dependent: :destroy
  has_many :snippets, through: :stories

  def get_contribution_color(story)
    Contribution.find_by(story: story, user: self).color
  end
end
