class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :group_id, :integer
    add_column :users, :active, :boolean
    add_column :users, :name, :string
    add_column :users, :roll, :string
  end

  def self.down
    remove_column :users, :group_id
    remove_column :users, :active
    remove_column :users, :name
    remove_column :users, :roll
  end
end
