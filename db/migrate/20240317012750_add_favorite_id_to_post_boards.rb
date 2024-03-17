class AddFavoriteIdToPostBoards < ActiveRecord::Migration[6.1]
  def change
    add_column :post_boards, :favorite_id, :integer
  end
end
