class Users < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :introductio, :introduction
  end
end
