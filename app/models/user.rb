class User < ApplicationRecord
  has_secure_password

  has_many :contributions
  has_many :stories, through: :contributions
  has_many :snippets, through: :stories

  validates :email, presence: true 

  validates_with AccountValidator

  def get_contribution_color(story)
    contribution = Contribution.find_by(user: self, story: story) 

    "##{contribution.color}" if contribution
  end
end
