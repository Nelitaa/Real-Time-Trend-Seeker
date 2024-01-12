class Search < ApplicationRecord
  validates :term, presence: true
  belongs_to :user
end
