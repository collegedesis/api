class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :recipient_email
      t.integer :bulletin_id
      t.timestamps
    end
  end
end
