class User < ApplicationRecord
  validates :ip, presence: true, uniqueness: true

  has_many :searches
end
