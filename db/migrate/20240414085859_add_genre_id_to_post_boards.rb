class AddGenreIdToPostBoards < ActiveRecord::Migration[6.1]
  def change
    add_column :post_boards, :genre_id, :integer
  end
end
