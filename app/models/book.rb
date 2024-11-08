class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
