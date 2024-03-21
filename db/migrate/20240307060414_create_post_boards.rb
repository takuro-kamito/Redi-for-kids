class CreatePostBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :post_boards do |t|
      t.text :body, null: false

      t.timestamps
    end
  end
end
