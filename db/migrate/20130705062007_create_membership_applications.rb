class CreateMembershipApplications < ActiveRecord::Migration
  def change
    create_table :membership_applications do |t|
      t.integer :user_id
      t.integer :membership_id
      t.integer :membership_type_id
      t.string :status

      t.timestamps
    end
  end
end
