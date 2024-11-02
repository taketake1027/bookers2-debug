class BookComment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :body, presence: true  # 空のコメントは保存できない
end
