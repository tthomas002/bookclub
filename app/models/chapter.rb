class Chapter < ApplicationRecord
  belongs_to :book
  has_many :posts, dependent: :destroy
  validates :number, presence: :true, numericality: { greater_than: 0 }
  validates :title, presence: :true
end
