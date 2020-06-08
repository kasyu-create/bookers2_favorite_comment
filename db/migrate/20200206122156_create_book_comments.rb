class CreateBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :book_comments do |t|
      t.integer :user_id
      #外部キー　誰の投稿か把握するため
      t.integer :book_id
      #外部キー　誰のどの投稿か把握するため
      t.text :comment
      #主キー　コメントテーブルを識別するための値
      #自分自身のcommentのIDは自動で作られるから記述はない
      t.timestamps
    end
  end
end
