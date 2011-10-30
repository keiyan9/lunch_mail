class CreateNoticePoints < ActiveRecord::Migration
  def self.up
    create_table :notice_points do |t|
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :notice_points
  end
end
