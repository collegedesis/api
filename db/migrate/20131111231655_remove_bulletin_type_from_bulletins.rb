class RemoveBulletinTypeFromBulletins < ActiveRecord::Migration
  def change
    remove_column :bulletins, :bulletin_type
  end
end
