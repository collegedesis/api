class RemoveColumnShortendUrlFromBulletins < ActiveRecord::Migration
  def change
    remove_column :bulletins, :shortened_url
  end
end
