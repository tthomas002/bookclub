class Post < ApplicationRecord
  belongs_to :chapter
  has_rich_text :content
end
