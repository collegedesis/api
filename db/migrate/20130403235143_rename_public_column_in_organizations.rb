class RenamePublicColumnInOrganizations < ActiveRecord::Migration
  def change
    rename_column :organizations, :public, :exposed
  end
end
