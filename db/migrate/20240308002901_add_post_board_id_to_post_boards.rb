class AddPostBoardIdToPostBoards < ActiveRecord::Migration[6.1]
  def change
    add_column :post_boards, :post_board_id, :integer
  end
end
