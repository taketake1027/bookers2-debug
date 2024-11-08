class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    # 一意性制約を追加（ユーザーが一つの投稿に一つしかいいねできない）
    add_index :favorites, [:user_id, :book_id], unique: true
  end
end
