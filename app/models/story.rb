class Story < ApplicationRecord
  belongs_to :user
  has_many :contributions
  has_many :snippets
end
