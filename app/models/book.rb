class Book < ApplicationRecord
  validates :title, presence: true
  has_many :chapters, dependent: :destroy
end
