class AddUserIdBookIdUniqIndexFromFavorite < ActiveRecord::Migration[5.2]
  def change
    add_index :favorites, [:user_id, :book_id], unique: true
  end
end
