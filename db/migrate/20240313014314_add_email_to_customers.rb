class AddEmailToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :email, :string
  end
end
