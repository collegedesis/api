class AddDeadToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :is_dead, :boolean, :default => false
  end
end
