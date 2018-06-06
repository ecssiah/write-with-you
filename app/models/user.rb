class User < ApplicationRecord
  has_secure_password

  has_many :contributions, dependent: :destroy
  has_many :stories, through: :contributions
  has_many :snippets, through: :stories

  validates :email, presence: true 
  validates_with AccountValidator

  def self.created_stories(user)
    Story.where(creator_id: user.id).order(rank: :desc)
  end

  def self.auth_error(user, info)
    if info[:user]
      local_auth_error(user, info)
    else
      omni_auth_error(user, info)
    end
  end

  def self.local_auth_error(user, info)
    if info[:user][:email].blank? || info[:user][:password].blank?
      "Fields can't be left blank"
    elsif !user
      "Email does not match existing user"
    elsif !user.authenticate(info[:user][:password])
      "Password is not correct"
    end
  end

  def self.omni_auth_error(user, info)
    if !user
      "Email does not match existing user"
    end
  end

  def get_contribution(story)
    Contribution.find_by(user: self, story: story) 
  end

  def get_contribution_color(story)
    contribution = get_contribution(story)
    "##{contribution.color}" if contribution
  end

  def set_contribution_color(story, color)
    contribution = Contribution.find_or_create_by(user: self, story: story)
    contribution.update(color: color)
  end

  def vote(story, vote)
    return unless [1, 2, 3, 4, 5].include?(vote.to_i)

    contribution = Contribution.find_or_create_by(story: story, user: self)
    contribution.update(vote: vote)

    story.update_rankings
  end

  def get_vote(story)
    contribution = get_contribution(story)
    contribution ? contribution.vote : 0
  end

end

