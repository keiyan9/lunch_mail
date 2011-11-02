class AddActiveToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :active, :boolean
  end

  def self.down
    remove_column :settings, :active
  end
end
