class RemoveNoticePointsTable < ActiveRecord::Migration
  def self.up
    drop_table :notice_points
  end

  def self.down
    create_table :notice_points do |t|
      t.string   :email
      t.integer  :user_id
      t.string   :name

      t.timestamps
    end
  end
end
