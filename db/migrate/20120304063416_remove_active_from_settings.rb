class RemoveActiveFromSettings < ActiveRecord::Migration
  def self.up
    remove_column :settings, :active
  end

  def self.down
    add_column :settings, :active, :boolean
  end
end
