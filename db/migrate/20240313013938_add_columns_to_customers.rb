class AddColumnsToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :name, :string
    add_column :customers, :name_kana, :string
    add_column :customers, :is_active, :boolean
  end
end
