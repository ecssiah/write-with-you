class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :validatable

  has_many :stories
  has_many :contributions
  has_many :snippets, through: :stories

  def will_save_change_to_email?
    false
  end

end
