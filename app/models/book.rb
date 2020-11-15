class Book < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :requests
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  validates :book_type, presence: true
  validates :isbn, presence: true
  validates :book_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end

end
