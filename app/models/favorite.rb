class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # ユーザーと投稿の組み合わせが一意であることを保証
  validates :user_id, uniqueness: { scope: :book_id }
end
