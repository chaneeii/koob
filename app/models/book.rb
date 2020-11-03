class Book < ApplicationRecord
  belongs_to :user

  validates :book_type, presence: true
  validates :isbn, presence: true
  validates :book_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true
end
