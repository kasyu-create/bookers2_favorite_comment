class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :book_id
      #外部キー　誰のどの投稿か把握するため
      t.integer :user_id
      #外部キー　誰の投稿か把握するため

      t.timestamps
    end
  end
end
