class RemoveColumnsFromCommunities < ActiveRecord::Migration[6.1]
  def change
    remove_column :communities, :genre_id, :integer
  end
end
