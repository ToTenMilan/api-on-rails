class Order < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  has_many :placements
  has_many :products, through: :placements
end
