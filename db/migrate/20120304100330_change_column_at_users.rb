class ChangeColumnAtUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :active
    add_column :users, :active, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :users, :active
    add_column :users, :active, :boolean
  end
end
