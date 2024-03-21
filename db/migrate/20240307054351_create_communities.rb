class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      
      t.string :name, null: false, default: ""
      t.text :explanation, null: false
      t.timestamps
    end
  end
end
