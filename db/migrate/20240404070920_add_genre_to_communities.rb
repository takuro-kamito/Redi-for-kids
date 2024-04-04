class AddGenreToCommunities < ActiveRecord::Migration[6.1]
  def change
    add_column :communities, :genre_id, :integer
  end
end
