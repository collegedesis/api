class AddUserIdToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :user_id, :integer
  end
end
