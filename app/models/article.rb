class Article < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_full_text, against: {
    title: 'A',
    content: 'B'
  }

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
end
