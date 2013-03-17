class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :submitted_by_ip
      t.integer :user_id

      t.timestamps
    end
  end
end
