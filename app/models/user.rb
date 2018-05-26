class User < ApplicationRecord
  has_secure_password

  has_many :contributions
  has_many :stories, through: :contributions
  has_many :snippets, through: :stories

  def get_contribution_color(story)
    contribution = Contribution.find_by(user: self, story: story) 

    if contribution
      "##{contribution.color}" 
    end
  end
end
