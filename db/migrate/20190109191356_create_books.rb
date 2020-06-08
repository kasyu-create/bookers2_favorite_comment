class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      #自分自身のbook.idは自動で作られるから記述はない。
      t.timestamps
    end
  end
end
