class AddScoreToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :score, :integer, default: 0
  end
end
