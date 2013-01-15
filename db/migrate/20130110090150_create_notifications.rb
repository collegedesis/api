class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.recipient_email :integer
      t.bulletin_id :integer
      t.timestamps
    end
  end
end
