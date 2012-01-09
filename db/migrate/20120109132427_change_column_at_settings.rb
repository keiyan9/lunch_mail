class ChangeColumnAtSettings < ActiveRecord::Migration
  def self.up
    remove_column :settings, :user_id
    add_column :settings, :group_id, :integer
  end

  def self.down
    add_column :settings, :user_id, :integer
    remove_column :settings, :group_id
  end
end
