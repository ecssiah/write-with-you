class User < ApplicationRecord
  has_secure_password

  has_many :stories
  has_many :contributions, dependent: :destroy
  has_many :snippets, through: :stories
end
