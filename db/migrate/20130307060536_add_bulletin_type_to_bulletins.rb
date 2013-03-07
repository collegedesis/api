class AddBulletinTypeToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :bulletin_type, :integer, default: 1
  end
end
