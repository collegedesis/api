class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :organization_id
      t.integer :message_id

      t.timestamps
    end
  end
end
