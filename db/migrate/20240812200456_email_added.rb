class EmailAdded < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :email, :string, null: false
    add_index :users, :email, unique: true
  end
end
