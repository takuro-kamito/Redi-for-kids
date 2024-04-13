class ChangeColumnDefaultsInNotifications < ActiveRecord::Migration[6.1]
  def up
       remove_column :notifications, :checked
       add_column :notifications, :checked, :boolean, default: false, null: false
  end

     def down
       remove_column :notifications, :checked
       add_column :notifications, :checked, :boolean
     end
end
