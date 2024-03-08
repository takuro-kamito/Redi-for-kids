class AddCommunityIdToPostBoards < ActiveRecord::Migration[6.1]
  def change
    add_column :post_boards, :community_id, :integer
  end
end
