class Book < ApplicationRecord
  validates :title, presence: true
  has_many :chapters, dependent: :destroy

  def next_chapter_number
    self.chapters.count + 1
  end
end
