class AddNameToNoticePoint < ActiveRecord::Migration
  def self.up
    add_column :notice_points, :name, :string
  end

  def self.down
    remove_column :notice_points, :name
  end
end
