class Post < ApplicationRecord
  belongs_to :chapter
  belongs_to :user
  has_rich_text :content

  validates :content, presence: true
  validates :title, presence: true
end
