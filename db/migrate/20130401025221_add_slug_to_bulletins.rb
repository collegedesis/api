class AddSlugToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :slug, :string
  end
end
